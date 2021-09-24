import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/models/acto_requisito.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class TramiteProvider {
  final tramiteStreamController = PublishSubject<DatosProforma>();
  final _misTramitesStreamController = PublishSubject<List<Solicitud>>();
  final _requsitosStreamController = PublishSubject<List<ActoRequisito>>();

  Stream<DatosProforma> get proformaStream => tramiteStreamController.stream;

  Stream<List<Solicitud>> get misTramitesStream =>
      _misTramitesStreamController.stream;

  Stream<List<ActoRequisito>> get requsitosStreamController =>
      _requsitosStreamController.stream;

  void disposeStreams() {
    tramiteStreamController.close();
  }

  Future<DatosProforma?> consultarTramite(int tramite) async {
    try {
      Map<String, dynamic> map = await find(
          '/rpm-ventanilla/api/solicitud/consultar/tramite/$tramite', true);
      DatosProforma? datosProforma = DatosProforma.fromJson(map);
      return datosProforma;
    } catch (e) {
      print(e);
    }
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

  Future<List<Solicitud>>? findMisSolicitudes(int usuario) async {
    print('/rpm-ventanilla/api/solicitud/solicitudes/usuario/$usuario');
    List<dynamic>? collection = await findAll(
        '/rpm-ventanilla/api/solicitud/solicitudes/usuario/$usuario', true);
    List<Solicitud>? solicitudes =
        collection!.map((p) => Solicitud().fromJson(p)).toList();
    return solicitudes;
  }

  findSolicitudes() async {
    User? u = await userLogged();
    List<dynamic>? collection = await findAll(
        '/rpm-ventanilla/api/solicitud/solicitudes/usuario/${u!.id}', true);
    List<Solicitud>? solicitudes =
        collection!.map((p) => Solicitud().fromJson(p)).toList();
    _misTramitesStreamController.add(solicitudes);
  }

  findRequisitos() async {
    User? u = await userLogged();
    List<dynamic>? collection = await findAll(
        '/rpm-ventanilla/api/solicitud/solicitudes/requisitos/usuario/${u!.id}',
        true);
    List<ActoRequisito>? list =
        collection!.map((p) => ActoRequisito().fromJson(p)).toList();
    _requsitosStreamController.add(list);
  }
}
