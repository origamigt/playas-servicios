import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/configs/rpm_preferences.dart';
import 'package:playas/src/models/codigo.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/models/usuario_registro.dart';
import 'package:playas/src/providers/ws.dart';

enum Status {
  Unknown,
  NotLoggedIn,
  LoggedIn,
  Authenticating,
  LoggedOut,
}

enum StatusRegistro {
  Unknown,
  NotRegistered,
  Registered,
  Registering,
  CodigoEnviando,
  CodigoEnviado,
  CodigoNoEnviado,
  ValidarCodCargando,
  ValidarCodOk,
  ValidarCodNoOk,
  ClaveActualizando,
  ClaveActualizada,
  ClaveNoActualizada,
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.Unknown;
  StatusRegistro _registeredInStatus = StatusRegistro.Unknown;

  Status get loggedInStatus => _loggedInStatus;

  StatusRegistro get registeredInStatus => _registeredInStatus;

  void setAuthState(Status authState) {
    _loggedInStatus = authState;
    notifyListeners();
  }

  void setRegisterState(StatusRegistro registerState) {
    _registeredInStatus = registerState;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    User usr = User();
    usr.clave = password;
    usr.usuario = email;
    usr.habilitado = true;
    String path = 'rpm-ventanilla/api/autentificacion';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);

    http.Response response = await http.post(uri,
        body: json.encode({"username": email, "password": password}),
        headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      await PrefencesRPM.deleteAllKeys();

      var jwt = map['token'];
      await spDelete(kJWT);
      await spSaveValue(kJWT, jwt);
      path = 'rpm-ventanilla/api/usuario/loginUser';
      uri =
          isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);
      response =
          await http.post(uri, body: json.encode(usr), headers: headerNoAuth);

      try {
        map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;
        User u = User().fromJson(map);
        var uJS = json.encode(u);
        await PrefencesRPM.saveValue(kUser, uJS);
        await PrefencesRPM.saveValue(kThereUser, kThereUserOK);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'user': u};
      } catch (e) {
        print(e);
      }
    } else {
      Data data = Data().fromJson(map);
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {'status': false, 'message': 'Datos incorrectos'};
    }
    return result;
  }

  Future<Map<String, dynamic>> buscarUsuario(
      String identificacion, String fechaExpedicion, bool tipo) async {
    var result;

    final Map<String, dynamic> registrationData = {
      'identificacion': identificacion,
      'fechaExpedicion': fechaExpedicion
    };

    _registeredInStatus = StatusRegistro.Registering;
    notifyListeners();

    String path = tipo
        ? 'rpm-ventanilla/api/usuario/consultar'
        : 'rpm-ventanilla/api/usuario/consultar/recuperar';

    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);

    http.Response response = await http.post(uri,
        body: json.encode(registrationData), headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    //   print(response.body);
    if (response.statusCode == 200) {
      _registeredInStatus = StatusRegistro.NotRegistered;
      notifyListeners();
      UsuarioRegistro usuarioRegistro = UsuarioRegistro().fromJson(map);
      result = {
        'status': true,
        'message': 'Usuario no registrado',
        'data': usuarioRegistro
      };
    } else {
      _registeredInStatus = StatusRegistro.Unknown;
      notifyListeners();
      Data data = Data().fromJson(map);
      result = {
        'status': false,
        'message': data.data,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> enviarCodigoVerificacion(String identificacion,
      String persona, String correo, String celular) async {
    var result;

    CodigoVerificacion cv = CodigoVerificacion();
    cv.validado = false;
    cv.correo = correo;
    cv.persona = persona;
    cv.celular = celular;
    cv.identificacion = identificacion;

    Map<String, dynamic> verificacion = CodigoVerificacion().json(cv);

    _registeredInStatus = StatusRegistro.CodigoEnviando;
    notifyListeners();
    String path = 'rpm-ventanilla/api/correo/generarCodigoRegistro';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);

    http.Response response = await http.post(uri,
        body: json.encode(verificacion), headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      _registeredInStatus = StatusRegistro.CodigoEnviado;
      notifyListeners();
      CodigoVerificacion data = CodigoVerificacion().fromJson(map);
      result = {'status': true, 'message': 'Datos encontrados', 'data': data};
    } else {
      _registeredInStatus = StatusRegistro.CodigoNoEnviado;
      notifyListeners();
      Data data = Data().fromJson(map);
      result = {
        'status': false,
        'message': data.data,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> validarCodigoRegistroUsuario(
      String correo,
      String codigo,
      String celular,
      String identificacion,
      String direccion,
      String clave,
      int personaid,
      bool creado,
      String tipo,
      Uint8List? archivo) async {
    var result;
    UsuarioRegistro ur = UsuarioRegistro();
    ur.personaId = personaid;
    ur.identificacion = identificacion;
    ur.direccion = direccion;
    ur.correo = correo;
    ur.celular = celular;
    ur.clave = clave;
    ur.creado = creado;
    ur.tipo = tipo;
    ur.archivo = archivo;

    CodigoVerificacion cv = CodigoVerificacion();
    cv.correo = correo;
    cv.codigo = codigo;
    cv.usuarioRegistro = ur;

    Map<String, dynamic> verificacion = CodigoVerificacion().jsonRegistro(cv);
    _registeredInStatus = StatusRegistro.ValidarCodCargando;
    notifyListeners();
    String path = 'rpm-ventanilla/api/correo/validarCodigoRegistro';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);
    http.Response response = await http.post(uri,
        body: json.encode(verificacion), headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      _registeredInStatus = StatusRegistro.ValidarCodOk;
      notifyListeners();
      CodigoVerificacion data = CodigoVerificacion().fromJson(map);
      result = {'status': true, 'message': 'Datos encontrados', 'data': data};
    } else {
      _registeredInStatus = StatusRegistro.ValidarCodNoOk;
      notifyListeners();
      Data data = Data().fromJson(map);
      result = {
        'status': false,
        'message': data.data,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> validarCodigoRecuperacion(
      String correo, String codigo, String identificacion) async {
    var result;

    CodigoVerificacion cv = CodigoVerificacion();
    cv.correo = correo;
    cv.codigo = codigo;
    cv.identificacion = identificacion;

    Map<String, dynamic> verificacion = CodigoVerificacion().jsonRegistro(cv);

    _registeredInStatus = StatusRegistro.ValidarCodCargando;
    notifyListeners();
    String path = 'rpm-ventanilla/api/correo/validarCodigo';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);
    http.Response response = await http.post(uri,
        body: json.encode(verificacion), headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      _registeredInStatus = StatusRegistro.ValidarCodOk;
      notifyListeners();
      CodigoVerificacion data = CodigoVerificacion().fromJson(map);
      result = {'status': true, 'message': 'Datos encontrados', 'data': data};
    } else {
      _registeredInStatus = StatusRegistro.ValidarCodNoOk;
      notifyListeners();
      Data data = Data().fromJson(map);
      result = {
        'status': false,
        'message': data.data,
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> actualizarContrasenia(
      String clave, String identificacion) async {
    var result;

    final Map<String, dynamic> registrationData = {
      'usuario': identificacion,
      'clave': clave
    };

    _registeredInStatus = StatusRegistro.ClaveActualizando;
    notifyListeners();
    print(json.encode(registrationData));
    String path = 'rpm-ventanilla/api/usuario/actualizarContrasenia';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);
    http.Response response = await http.post(uri,
        body: json.encode(registrationData), headers: headerNoAuth);
    if (response != null) {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;
        _registeredInStatus = StatusRegistro.ClaveActualizada;
        notifyListeners();
        User data = User().fromJson(map);
        result = {'status': true, 'message': 'Datos encontrados', 'data': data};
      } else {
        Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;
        _registeredInStatus = StatusRegistro.ClaveNoActualizada;
        notifyListeners();
        Data data = Data().fromJson(map);
        result = {
          'status': false,
          'message': data.data,
        };
      }
    } else {
      result = {
        'status': false,
        'message': 'Intente nuevamente',
      };
    }
    return result;
  }
}
