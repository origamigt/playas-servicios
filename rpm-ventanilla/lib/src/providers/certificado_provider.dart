import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/models/images-certificados.dart';
import 'package:playas/src/providers/ws.dart';

enum StatusCertificadoProv { Unknown, Searching, Found, NoFound }

class CertificadoProvider extends ChangeNotifier {
  StatusCertificadoProv _status = StatusCertificadoProv.Unknown;

  StatusCertificadoProv get status => _status;

  void setState(StatusCertificadoProv state) {
    _status = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> validarCertificado(
      String codigo, String tipo) async {
    var result;

    _status = StatusCertificadoProv.Searching;
    notifyListeners();

    http.Response? response = await findAllResponse(
        '/rpm-ventanilla/api/documento/codigo/$codigo/tipo/$tipo', true);

    if (response != null && response.statusCode == 200) {
      List<dynamic> collection = json.decode(utf8.decode(response.bodyBytes));

      try {
        List<ImagenesCertificados>? documentos =
            collection.map((p) => ImagenesCertificados().fromJson(p)).toList();
        _status = StatusCertificadoProv.Found;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'data': documentos};
      } catch (e) {
        print(e);
      }
    } else {
      _status = StatusCertificadoProv.NoFound;
      notifyListeners();
      result = {'status': false, 'message': 'Datos no encontrados'};
    }
    return result;
  }
}
