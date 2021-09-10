import 'package:playas/src/models/datos-detalle-proforma.dart';

part 'datos-proforma.g.dart';

class DatosProforma {
  int? idSolicitud;
  int? numerotramite;
  String? doc_solicitante;
  String? nombre_solicitante;
  String? correo_solicitante;
  String? doc_beneficiario;
  String? nombre_beneficiario;
  String? correo_beneficiario;
  String? revisor;
  String? numerofactura;
  String? estadotramite;
  String? mensaje;
  int? fechaingreso;
  int? fechaentrega;
  num? subtotal;
  num? descuento;
  double? totalPagar;
  List<DatosDetalleProforma>? detalle;
  String? acto;
  bool? procedePago;

  DatosProforma();

  factory DatosProforma.fromJson(Map<String, dynamic> json) =>
      _$DatosProformaFromJson(json);
}
