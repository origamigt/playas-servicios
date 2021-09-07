import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/models/acto_requisito.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:provider/provider.dart';

enum StatusPago { Unknown, Procesing, Done, Error }

class PagoProvider extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    print('Did hot-reload');
  }

  StatusPago _status = StatusPago.Unknown;

  StatusPago get status => _status;

  void setState(StatusPago state) {
    _status = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> procesarPago(
      Data motivo,
      String observacion,
      String identificacionSol,
      String datosSol,
      //String apellidosSol,
      String direccionSol,
      String telefonoSol,
      String correoSol,
      String estadoCivilSol,
      String identificacionFact,
      String datosFact,
      //String apellidosFact,
      String direccionFact,
      String telefonoFact,
      String correoFact,
      Acto acto,
      int user,
      String cantidad) async {
    var result;

    try {
      _status = StatusPago.Procesing;
      notifyListeners();

      List<String> sol = datosSol.split(' ');
      List<String> fact = datosFact.split(' ');
      int idSol = identificacionSol.length;
      int idBen = identificacionFact.length;

      Solicitud data = Solicitud();
      data.solTipoDoc = idSol == 10
          ? 'C'
          : idSol == 13
              ? 'J'
              : 'P';
      data.solApellidos = sol[0] + ' ' + sol[1];
      data.solNombres = sol[2] + ' ' + sol[3];
      data.solCedula = identificacionSol;
      data.solProvincia = direccionSol;
      data.solCelular = telefonoFact;
      data.solCorreo = correoSol;
      data.solEstadoCivil = estadoCivilSol != null ? estadoCivilSol : '';
      data.tipoSolicitud = acto.id;
      data.motivoSolicitud = motivo.id;
      data.otroMotivo = motivo.data;
      data.observacion = observacion;

      data.benTipoDoc = idBen == 10
          ? 'C'
          : idBen == 13
              ? 'J'
              : 'P';

      data.benDocumento = identificacionFact;
      data.benApellidos = fact[0] + ' ' + fact[1];
      data.benNombres = fact[2] + ' ' + fact[3];
      data.benDocumento = identificacionFact;
      data.benDireccion = direccionFact;
      data.benTelefono = telefonoFact;
      data.benCorreo = correoFact;
      //data.payframeUrl = 'identificacionFact';
      data.user = User();
      data.user!.id = user;
      data.cantidad = int.parse(cantidad);
      data.total = acto.valor! * num.parse(cantidad);
      data.estado = 'A';
      data.tipoPago = false;
      data.procesando = false;

      http.Response? response = await save(
          '/rpm-ventanilla/api/solicitud/registrarCertificado', data, true);

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;

        Solicitud rest = Solicitud().fromJson(map);
        _status = StatusPago.Done;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'data': rest};
      } else {
        _status = StatusPago.Error;
        notifyListeners();
        result = {
          'status': false,
          'message': 'No se pudo procesar la solicitud'
        };
      }
    } catch (e) {
      print(e);
      _status = StatusPago.Error;
      notifyListeners();
      result = {'status': false, 'message': 'Intente nuevamente'};
    }
    return result;
  }

  Future<Map<String, dynamic>> procesarInscripcion(
      String observacion,
      String identificacionSol,
      String datosSol,
      String direccionSol,
      String telefonoSol,
      String correoSol,
      String estadoCivilSol,
      String identificacionFact,
      String datosFact,
      String direccionFact,
      String telefonoFact,
      String correoFact,
      Acto acto,
      int user,
      List<ActoRequisito> requisitos) async {
    var result;

    try {
      _status = StatusPago.Procesing;
      notifyListeners();

      List<String> sol = datosSol.split(' ');
      List<String> fact = datosFact.split(' ');
      int idSol = identificacionSol.length;
      int idBen = identificacionFact.length;

      Solicitud data = Solicitud();
      data.solTipoDoc = idSol == 10
          ? 'C'
          : idSol == 13
              ? 'J'
              : 'P';
      data.solApellidos = sol[0] + ' ' + sol[1];
      data.solNombres = sol[2] + ' ' + sol[3];
      data.solCedula = identificacionSol;
      data.solProvincia = direccionSol;
      data.solCelular = telefonoFact;
      data.solCorreo = correoSol;
      data.solEstadoCivil = estadoCivilSol != null ? estadoCivilSol : '';
      data.tipoSolicitud = acto.id;
      data.observacion = observacion;

      data.benTipoDoc = idBen == 10
          ? 'C'
          : idBen == 13
              ? 'J'
              : 'P';

      data.benDocumento = identificacionFact;
      data.benApellidos = fact[0] + ' ' + fact[1];
      data.benNombres = fact[2] + ' ' + fact[3];
      data.benDocumento = identificacionFact;
      data.benDireccion = direccionFact;
      data.benTelefono = telefonoFact;
      data.benCorreo = correoFact;
      //data.payframeUrl = 'identificacionFact';
      data.user = User();
      data.user!.id = user;
      /* data.cantidad = int.parse(cantidad);
      data.total = acto.valor! * num.parse(cantidad);*/
      data.estado = 'A';
      data.tipoPago = false;
      data.procesando = false;
      data.requisitos = requisitos;

      http.Response? response = await save(
          '/rpm-ventanilla/api/solicitud/registrarInscripcion',
          Solicitud().json(data),
          true);

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;

        Solicitud rest = Solicitud().fromJson(map);
        _status = StatusPago.Done;
        notifyListeners();

        result = {
          'status': true,
          'message': 'Solicitud generada correctamente',
          'data': rest
        };
      } else {
        _status = StatusPago.Error;
        notifyListeners();
        result = {
          'status': false,
          'message': 'No se pudo procesar la solicitud'
        };
      }
    } catch (e) {
      print(e);
      _status = StatusPago.Error;
      notifyListeners();
      result = {'status': false, 'message': 'Intente nuevamente'};
    }
    return result;
  }

  Future<Map<String, dynamic>> procederPagoInscripcion(int idSolicitud) async {
    var result;

    try {
      _status = StatusPago.Procesing;
      notifyListeners();

      Solicitud data = Solicitud();
      data.id = idSolicitud;
      data.tipoSolicitud = 0;

      http.Response? response = await save(
          '/rpm-ventanilla/api/solicitud/registrarPagoEnLina',
          Solicitud().json(data),
          true);

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;

        Solicitud rest = Solicitud().fromJson(map);
        _status = StatusPago.Done;
        notifyListeners();

        result = {
          'status': true,
          'message': 'Solicitud generada correctamente',
          'data': rest
        };
      } else {
        _status = StatusPago.Error;
        notifyListeners();
        result = {
          'status': false,
          'message': 'No se pudo procesar la solicitud'
        };
      }
    } catch (e) {
      print(e);
      _status = StatusPago.Error;
      notifyListeners();
      result = {'status': false, 'message': 'Intente nuevamente'};
    }
    return result;
  }
}
