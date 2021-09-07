import 'package:playas/src/models/datos-detalle-proforma.dart';

part 'datos-proforma.g.dart';

class DatosProforma {
  int? idSolicitud;
  int? numerotramite;
  int? repertorio;
  String? doc_solicitante;
  String? nombre_solicitante;
  String? correo_solicitante;
  String? doc_beneficiario;
  String? nombre_beneficiario;
  String? correo_beneficiario;
  String? revisor;
  String? numerofactura;
  String? claveacceso;
  String? numeroautorizacion;
  String? estadotramite;
  String? mensaje;
  int? fechaingreso;
  int? fechaentrega;
  num? subtotal;
  num? descuento;
  num? dscto_limitcobro;
  num? descuento_porc;
  num? gastos_generales;
  num? totalPagar;
  double? avance;
  List<DatosDetalleProforma>? detalle;
  String? detalleSolicitud;
  String? detalleAvance;
  String? acto;

  DatosProforma();

  factory DatosProforma.fromJson(Map<String, dynamic> json) =>
      _$DatosProformaFromJson(json);
}
