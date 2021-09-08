// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datos-detalle-proforma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatosDetalleProforma _$DatosDetalleProformaFromJson(Map<String, dynamic> json) {
  return DatosDetalleProforma()
    ..acto = json['acto'] as String? ?? null
    ..valorUnitario = json['valorUnitario'] as num? ?? null
    ..descuento = json['descuento'] as num? ?? null
    ..valorTotal = json['valorTotal'] as num? ?? null;
}

/*Map<String, dynamic> _$DatosDetalleProformaToJson(
        DatosDetalleProforma instance) =>
    <String, dynamic>{
      'cantidad': instance.cantidad,
      'acto': instance.acto,
      'cuantia': instance.cuantia,
      'avaluo': instance.avaluo,
      'valorUnitario': instance.valorUnitario,
      'descuento': instance.descuento,
      'conceptoDescuento': instance.conceptoDescuento,
      'valorTotal': instance.valorTotal
    };*/
