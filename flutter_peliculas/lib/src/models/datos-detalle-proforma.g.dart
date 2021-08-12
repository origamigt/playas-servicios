// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datos-detalle-proforma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatosDetalleProforma _$DatosDetalleProformaFromJson(Map<String, dynamic> json) {
  return DatosDetalleProforma()
    ..cantidad = json['cantidad'] as int
    ..acto = json['acto'] as String
    ..cuantia = json['cuantia'] as num
    ..avaluo = json['avaluo'] as num
    ..valorUnitario = json['valorUnitario'] as num
    ..descuento = json['descuento'] as num
    ..conceptoDescuento = json['conceptoDescuento'] as String
    ..valorTotal = json['valorTotal'] as num;
}

Map<String, dynamic> _$DatosDetalleProformaToJson(
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
    };
