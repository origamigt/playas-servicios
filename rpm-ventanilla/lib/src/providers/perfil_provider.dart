import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/configs/rpm_preferences.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:provider/provider.dart';

enum StatusPerfil { Unknown, Searching, Found, NoFound }

class PerfilProvider extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    print('Did hot-reload');
  }

  StatusPerfil _status = StatusPerfil.Unknown;

  StatusPerfil get status => _status;

  void setState(StatusPerfil state) {
    _status = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> actualizarPerfil(
      String identificacion,
      String direccion,
      String telefono,
      String correo,
      User usuario,
      PubPersona p) async {
    var result;

    _status = StatusPerfil.Searching;
    notifyListeners();

    PubPersona persona = PubPersona();
    persona.cedRuc = identificacion;
    persona.direccion = direccion;
    persona.telefono1 = telefono;
    persona.correo1 = correo;

    http.Response? response = await save(
        '/rpm-ventanilla/api/persona/actualizar',
        PubPersona().json(persona),
        true);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      try {
        PubPersona data = PubPersona().fromJson(map);
        _status = StatusPerfil.Found;
        notifyListeners();
        p.direccion = direccion;
        p.telefono1 = telefono;
        p.correo1 = correo;
        usuario.persona = p;

        var uJS = json.encode(usuario);
        await PrefencesRPM.deleteKey(kUser);
        await PrefencesRPM.saveValue(kUser, uJS);

        result = {
          'status': true,
          'message': 'Datos actualizados correctamente',
          'data': data
        };
      } catch (e) {
        _status = StatusPerfil.NoFound;
        notifyListeners();
        result = {'status': false, 'message': 'Intente nuevamente'};
      }
    } else {
      _status = StatusPerfil.NoFound;
      notifyListeners();
      result = {'status': false, 'message': 'Datos no encontrados'};
    }
    return result;
  }

  Future<Map<String, dynamic>> actualizarContrasenia(
      String clave, String identificacion, int id) async {
    var result;

    final Map<String, dynamic> registrationData = {
      'id': id,
      'usuario': identificacion,
      'clave': clave
    };

    _status = StatusPerfil.Searching;
    notifyListeners();

    http.Response response = await http.post(
        Uri.http(
            SERVER_IP, '/rpm-ventanilla/api/usuario/actualizarContrasenia'),
        body: json.encode(registrationData),
        headers: headerNoAuth);

    Map<String, dynamic> map =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      _status = StatusPerfil.Found;
      notifyListeners();
      User data = User().fromJson(map);
      result = {
        'status': true,
        'message': 'Su clave ha sido actualizada',
        'data': data
      };
    } else {
      _status = StatusPerfil.NoFound;
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
