import 'dart:async';

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

    Map<String, dynamic> map =
        await save('/api/pagos/verificarPago', verificarPago, true);
    ResponseCreate rc = ResponseCreate.fromJson(map);
    return rc;
  }
}
