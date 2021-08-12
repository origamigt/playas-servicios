
part 'datos-detalle-proforma.g.dart';

class DatosDetalleProforma {
  int? cantidad;
  String? acto;
  num? cuantia;
  num? avaluo;
  num? valorUnitario;
  num? descuento;
  String? conceptoDescuento;
  num? valorTotal;

  DatosDetalleProforma();

  factory DatosDetalleProforma.fromJson(Map<String, dynamic> json) => _$DatosDetalleProformaFromJson(json);
}
