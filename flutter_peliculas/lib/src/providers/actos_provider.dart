import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class ActosProvider {
  int _actosPage = 0;
  bool _cargando = false;

  List<Acto> _actos = [];

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
    final url = Uri.http(SERVER_IP, '/rpm-ventanilla/api/actosPopulares');
    List<Acto>? actos = await _procesarRespuesta(url);
    _actosStreamController.add(actos!);
  }

  findActos() async {
    final url = Uri.http(SERVER_IP, '/rpm-ventanilla/api/actos');
    List<Acto>? actos = await _procesarRespuesta(url);
    _actosStreamController.add(actos!);
  }
}
