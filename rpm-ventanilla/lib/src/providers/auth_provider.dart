import 'dart:async';
import 'dart:convert';

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
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.Unknown;
  StatusRegistro _registeredInStatus = StatusRegistro.Unknown;
  //Status _codigoStatus = Status.CodigoUnknown;
  //Status _validarCodigoStatus = Status.ValidarCodUnknown;

  Status get loggedInStatus => _loggedInStatus;

  StatusRegistro get registeredInStatus => _registeredInStatus;

  void setAuthState(Status authState) {
    _loggedInStatus = authState;
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

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/autentificacion'),
        body: json.encode({"username": email, "password": password}),
        headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      await PrefencesRPM.deleteAllKeys();

      var jwt = map['token'];
      await spDelete(kJWT);
      await spSaveValue(kJWT, jwt);

      response = await http.post(
          Uri.http(SERVER_IP, '/rpm-ventanilla/api/usuario/loginUser'),
          body: json.encode(usr),
          headers: await mapHeaderAuth());

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

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/usuario/consultar'),
        body: json.encode(registrationData),
        headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

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
    cv.identificacion = identificacion;

    Map<String, dynamic> verificacion = CodigoVerificacion().json(cv);

    _registeredInStatus = StatusRegistro.CodigoEnviando;
    notifyListeners();

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/correo/generarCodigoRegistro'),
        body: json.encode(verificacion),
        headers: headerNoAuth);

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
      int personaid) async {
    var result;

    UsuarioRegistro ur = UsuarioRegistro();
    ur.personaId = personaid;
    ur.identificacion = identificacion;
    ur.direccion = direccion;
    ur.correo = correo;
    ur.celular = celular;
    ur.clave = clave;

    CodigoVerificacion cv = CodigoVerificacion();
    cv.correo = correo;
    cv.codigo = codigo;
    cv.usuarioRegistro = ur;

    Map<String, dynamic> verificacion = CodigoVerificacion().jsonRegistro(cv);

    _registeredInStatus = StatusRegistro.ValidarCodCargando;
    notifyListeners();

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/correo/validarCodigoRegistro'),
        body: json.encode(verificacion),
        headers: headerNoAuth);

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

    Map<String, dynamic> verificacion = CodigoVerificacion().jsonRegistro(cv);

    _registeredInStatus = StatusRegistro.ValidarCodCargando;
    notifyListeners();

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/correo/validarCodigo'),
        body: json.encode(verificacion),
        headers: headerNoAuth);

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
}
