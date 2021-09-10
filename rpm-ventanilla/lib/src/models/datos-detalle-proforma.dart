part 'datos-detalle-proforma.g.dart';

class DatosDetalleProforma {
  String? acto;
  num? valorUnitario;
  num? descuento;
  num? valorTotal;

  DatosDetalleProforma();

  factory DatosDetalleProforma.fromJson(Map<String, dynamic> json) =>
      _$DatosDetalleProformaFromJson(json);
}
