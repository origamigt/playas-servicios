import 'dart:async';
import 'dart:convert';

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
    Map<String, String> header = await headerNoAuth;
    http.Response response = await http.get(url, headers: header);
    return utf8.decode(response.bodyBytes);
  }

  Future<String?> findTerminosCondiciones() async {
    String path = 'rpm-ventanilla/api/terminosCondicion';
    Uri uri =
        isDev ? Uri.http(SERVER_IP, path) : Uri.https(SERVER_IP, CONTEXT + path);
    String? terminos = await _procesarRespuesta(uri);
    return terminos;
  }
}
