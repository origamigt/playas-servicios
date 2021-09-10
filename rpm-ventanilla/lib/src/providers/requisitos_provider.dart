import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/models/acto_requisito.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:provider/provider.dart';

enum StatusRequisitos { Unknown, Searching, Found, NoFound }

class RequisitosProvider extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    print('Did hot-reload');
  }

  StatusRequisitos _status = StatusRequisitos.Unknown;

  StatusRequisitos get status => _status;

  void setState(StatusRequisitos state) {
    _status = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> requisitosXacto(int idActo) async {
    var result;

    _status = StatusRequisitos.Searching;
    notifyListeners();

    http.Response? response =
        await findAllResponse('/rpm-ventanilla/api/requisitos/$idActo', false);
    print(response!.body);
    if (response != null && response.statusCode == 200) {
      List<dynamic> collection = json.decode(utf8.decode(response.bodyBytes));

      try {
        List<ActoRequisito> requisitos =
            collection.map((p) => ActoRequisito().fromJson(p)).toList();
        _status = StatusRequisitos.Found;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'data': requisitos};
      } catch (e) {
        _status = StatusRequisitos.NoFound;
        notifyListeners();
        result = {'status': false, 'message': 'Intente nuevamente'};
      }
    } else {
      _status = StatusRequisitos.NoFound;
      notifyListeners();
      result = {'status': false, 'message': 'Datos no encontrados'};
    }
    return result;
  }
}
