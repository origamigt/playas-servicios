import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/configs/rpm_preferences.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/models/usuario_registro.dart';
import 'package:playas/src/providers/ws.dart';

enum Status {
  Unknown,
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
  SmsEnviando,
  SmsEnviado,
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.Unknown;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

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
      String identificacion, String fechaExpedicion) async {
    var result;

    final Map<String, dynamic> registrationData = {
      'identificacion': identificacion,
      'fechaExpedicion': fechaExpedicion
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/usuario/consultar'),
        body: json.encode(registrationData),
        headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      _registeredInStatus = Status.Registered;
      notifyListeners();
      UsuarioRegistro usuarioRegistro = UsuarioRegistro().fromJson(map);
      result = {
        'status': true,
        'message': 'Datos encontrados',
        'data': usuarioRegistro.nombresCompletos
      };
    } else {
      _registeredInStatus = Status.NotRegistered;
      Data data = Data().fromJson(map);
      result = {
        'status': false,
        'message': data.data,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> enviarCodigoVerificacion(
      String identificacion, String celular) async {
    var result;

    final Map<String, dynamic> registrationData = {
      'identificacion': identificacion,
      'celular': celular
    };

    _registeredInStatus = Status.SmsEnviando;
    notifyListeners();

    http.Response response = await http.post(
        Uri.http(SERVER_IP, '/rpm-ventanilla/api/usuario/consultar'),
        body: json.encode(registrationData),
        headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      UsuarioRegistro usuarioRegistro = UsuarioRegistro().fromJson(map);
      result = {
        'status': true,
        'message': 'Datos encontrados',
        'data': usuarioRegistro.nombresCompletos
      };
    } else {
      Data data = Data().fromJson(map);
      result = {
        'status': false,
        'message': data.data,
      };
    }

    return result;
  }
}
