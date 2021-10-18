part of 'ficha-registral.dart';

FichaRegistral _$FichaRegistralFromJson(Map<String, dynamic> json) {
  return FichaRegistral()
    ..id = json['id'] as int
    ..numFicha = json['numFicha'] as int
    ..tipoInmueble = json['tipoInmueble'] as String
    ..claveCatastral = json['claveCatastral'] as String
    ..parroquia = json['parroquia'] as String
    ..sector = json['sector'] as String
    ..manazana = json['manazana'] as String
    ..lote = json['lote'] as String
    ..solNumeroCasa = json['solNumeroCasa'] as String
    ..excedentePropietarios = json['excedentePropietarios'] as bool
    ..fichaPropietarios = (json['fichaPropietarios'] as List).map((e) => e == null
            ? null
            : FichaRegistralPropietarios.fromJson(e as Map<String, dynamic>))
        .cast<FichaRegistralPropietarios>().toList();
}

Map<String, dynamic> _$FichaRegistralToJson(FichaRegistral instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numFicha': instance.numFicha,
      'tipoInmueble': instance.tipoInmueble,
      'claveCatastral': instance.claveCatastral,
      'parroquia': instance.parroquia,
      'sector': instance.sector,
      'manazana': instance.manazana,
      'lote': instance.lote,
      'solNumeroCasa': instance.solNumeroCasa,
      'excedentePropietarios': instance.excedentePropietarios,
      'fichaPropietarios': instance.fichaPropietarios
    };
