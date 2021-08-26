import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playas/src/models/consulta_persona.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:provider/provider.dart';

enum StatusPersonProv { Unknown, Searching, SearchingFact, Found, NoFound }

class PersonaProvider extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    print('Did hot-reload');
  }

  StatusPersonProv _personaStatusPersonProv = StatusPersonProv.Unknown;

  StatusPersonProv get personaStatusPersonProv => _personaStatusPersonProv;

  void setPersonaState(StatusPersonProv authState) {
    _personaStatusPersonProv = authState;
    notifyListeners();
  }

  Future<Map<String, dynamic>> buscarPersona(
      String identificacion, String tipo) async {
    var result;

    _personaStatusPersonProv = tipo == 'SOLICITANTE'
        ? StatusPersonProv.Searching
        : StatusPersonProv.SearchingFact;
    notifyListeners();

    ConsultaPersona data = ConsultaPersona();
    data.identificacion = identificacion;
    data.aplicacion = 'APP_MOVIL';

    http.Response? response = await save('/rpm-ventanilla/api/consultarPersona',
        ConsultaPersona().toJson(data), true);

    if (response != null && response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      try {
        PubPersona persona = PubPersona().fromJson(map);
        _personaStatusPersonProv = StatusPersonProv.Found;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'persona': persona};
      } catch (e) {
        print(e);
      }
    } else {
      _personaStatusPersonProv = StatusPersonProv.NoFound;
      notifyListeners();
      result = {'status': false, 'message': 'Datos no encontrados'};
    }
    return result;
  }
}
