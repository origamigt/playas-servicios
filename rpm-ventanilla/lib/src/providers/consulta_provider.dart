import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/providers/ws.dart';

enum StatusConsultaProv { Unknown, Searching, Found, NoFound }

class ConsultaProvider extends ChangeNotifier {
  StatusConsultaProv _status = StatusConsultaProv.Unknown;

  StatusConsultaProv get status => _status;

  void setState(StatusConsultaProv state) {
    _status = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> consultarTramite(String tramite) async {
    var result;

    _status = StatusConsultaProv.Searching;
    notifyListeners();

    Map<String, dynamic> map = await find(
        '/rpm-ventanilla/api/solicitud/consultar/tramite/$tramite', true);
    if (map != null) {
      try {
        DatosProforma? datosProforma = DatosProforma.fromJson(map);
        _status = StatusConsultaProv.Found;
        notifyListeners();

        result = {
          'status': true,
          'message': 'Successful',
          'data': datosProforma
        };
      } catch (e) {
        print(e);
      }
    } else {
      _status = StatusConsultaProv.NoFound;
      notifyListeners();
      result = {'status': false, 'message': 'Datos no encontrados'};
    }
    return result;
  }
}
