import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class ActosProvider {
  final _actosStreamController = PublishSubject<List<Acto>>();

  Stream<List<Acto>> get actosStream => _actosStreamController.stream;

  void disposeStreams() {
    _actosStreamController.close();
  }

  Future<List<Acto>?> _procesarRespuesta(Uri url) async {
    Map<String, String> header = await mapHeaderAuth();
    http.Response response = await http.get(url, headers: header);
    List<dynamic>? collection = json.decode(utf8.decode(response.bodyBytes));

    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    return actos;
  }

  findActosPopulares() async {
    List<dynamic>? collection =
        await findAll('/rpm-ventanilla/api/actosPopulares', true);
    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    _actosStreamController.add(actos);
  }

  findActos() async {
    List<dynamic>? collection =
        await findAll('/rpm-ventanilla/api/actos', true);
    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    _actosStreamController.add(actos);
  }
}
