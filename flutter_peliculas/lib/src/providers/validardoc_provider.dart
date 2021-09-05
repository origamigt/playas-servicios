import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/models/archivo.dart';
import 'package:playas/src/models/documento.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:provider/provider.dart';

enum StatusValidarDoc { Unknown, Searching, Found, NoFound }

class ValidarDocProvider extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    print('Did hot-reload');
  }

  StatusValidarDoc _status = StatusValidarDoc.Unknown;

  StatusValidarDoc get status => _status;

  void setState(StatusValidarDoc state) {
    _status = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> validarDocumento(
      Uint8List? bytes, String? nombre) async {
    var result;

    _status = StatusValidarDoc.Searching;
    notifyListeners();

    Archivo doc = Archivo();
    doc.nombre = nombre;
    doc.multipartFile = bytes;

    http.Response? response = await save(
        '/rpm-ventanilla/api/document/documento/verificarArchivo',
        Archivo().toJson(doc),
        true);

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      try {
        Documento data = Documento().fromJson(map);
        _status = StatusValidarDoc.Found;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'data': data};
      } catch (e) {
        _status = StatusValidarDoc.NoFound;
        notifyListeners();
        result = {'status': false, 'message': 'Intente nuevamente'};
      }
    } else {
      _status = StatusValidarDoc.NoFound;
      notifyListeners();
      result = {'status': false, 'message': 'Datos no encontrados'};
    }
    return result;
  }
}
