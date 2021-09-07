import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class TramiteProvider {
  final tramiteStreamController = PublishSubject<DatosProforma>();

  Stream<DatosProforma> get proformaStream => tramiteStreamController.stream;

  void disposeStreams() {
    tramiteStreamController.close();
  }

  Future<DatosProforma?> consultarTramite(int tramite) async {
    Map<String, dynamic> map =
        await find('/api/solicitud/consultar/tramite/$tramite', true);
    DatosProforma? datosProforma = DatosProforma.fromJson(map);
    return datosProforma;
  }

  Future<DatosProforma?> consultarInscripcionXtramite(int tramite) async {
    Solicitud solicitud = Solicitud();
    solicitud.numeroTramite = tramite;

    http.Response? response = await save(
        '/rpm-ventanilla/api/solicitud/buscarTramite', solicitud, true);
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      Solicitud rest = Solicitud().fromJson(map);
      DatosProforma? proforma =
          await consultarTramite(rest.numeroTramiteInscripcion!);
      if (proforma != null) {
        proforma.idSolicitud = rest.id;
        return proforma;
      }
      return null;
    } else {
      return null;
    }
  }
}
