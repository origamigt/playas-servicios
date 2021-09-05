import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/models/response-create.dart';
import 'package:playas/src/models/verificar_pago.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class ResponseProvider {
  final responseStreamController = PublishSubject<String>();

  Stream<String> get terminosStream => responseStreamController.stream;

  void disposeStreams() {
    responseStreamController.close();
  }

  Future<ResponseCreate?> confirmarPago(
      String id, String clientTransactionId) async {
    VerificarPago verificarPago = VerificarPago();
    verificarPago.id = id;
    verificarPago.clientTxId = clientTransactionId;

    http.Response? response = await save(
        '/rpm-ventanilla/api/pagos/verificarPago', verificarPago, true);
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      ResponseCreate rest = ResponseCreate.fromJson(map);
      return rest;
    } else {
      return null;
    }
  }
}
