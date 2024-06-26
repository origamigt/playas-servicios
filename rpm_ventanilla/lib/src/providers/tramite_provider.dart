import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playas/src/models/acto_requisito.dart';
import 'package:playas/src/models/datos-proforma.dart';
import 'package:playas/src/models/facturas.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class TramiteProvider {
  final tramiteStreamController = PublishSubject<DatosProforma>();
  final _misTramitesStreamController = PublishSubject<List<Solicitud>>();
  final _misFacturasStreamController = PublishSubject<List<Facturas>>();
  final _requsitosStreamController = PublishSubject<List<ActoRequisito>>();

  Stream<DatosProforma> get proformaStream => tramiteStreamController.stream;

  Stream<List<Solicitud>> get misTramitesStream =>
      _misTramitesStreamController.stream;

  Stream<List<Facturas>> get misFacturasStream =>
      _misFacturasStreamController.stream;

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
      print(rest.numeroTramiteInscripcion!);
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

  findMisFacturas() async {
    User? u = await userLogged();
    List<dynamic>? collection = await findAll(
        'rpm-ventanilla/api/facturacionElectronica/consultaFacturasContribuyente/${u!.usuario}',
        true);
    print(collection.toString());
    if (collection != null) {
      try {
        List<Facturas>? facturas =
            collection.map((p) => Facturas().fromJson(p)).toList();
        _misFacturasStreamController.add(facturas);
      } catch (e) {
        _misFacturasStreamController.add([]);
      }
    }
  }

  findSolicitudes() async {
    User? u = await userLogged();
    List<dynamic>? collection = await findAll(
        'rpm-ventanilla/api/solicitud/solicitudes/usuario/${u!.id}', true);
    List<Solicitud>? solicitudes =
        collection!.map((p) => Solicitud().fromJson(p)).toList();
    _misTramitesStreamController.add(solicitudes);
  }

  findRequisitos() async {
    User? u = await userLogged();
    List<dynamic>? collection = await findAll(
        'rpm-ventanilla/api/solicitud/solicitudes/requisitos/usuario/${u!.id}',
        true);
    List<ActoRequisito>? list =
        collection!.map((p) => ActoRequisito().fromJson(p)).toList();
    _requsitosStreamController.add(list);
  }

  Future<Facturas?> reenviarFacturas(int tramite) async {
    try {
      Map<String, dynamic> map = await find(
          '/rpm-ventanilla/api/facturacionElectronica/reenviarFacturaContribuyente/$tramite',
          true);
      Facturas? datos = Facturas().fromJson(map);
      return datos;
    } catch (e) {
      print(e);
    }
  }
}
