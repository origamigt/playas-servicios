import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class TerminosProvider {
  final terminosStreamController = PublishSubject<String>();

  Stream<String> get terminosStream => terminosStreamController.stream;

  void disposeStreams() {
    terminosStreamController.close();
  }

  Future<String?> _procesarRespuesta(Uri url) async {
    Map<String, String> header = await mapHeaderAuth();
    http.Response response = await http.get(url, headers: header);
    return response.body;
  }

  Future<String?> findTerminosCondiciones() async {
    Map<String, dynamic> map = await find('/api/terminosCondicion/', true);
    String? terminos = map as String?;
    return terminos;
  }
}
