part of 'ficha-registral-propietarios.dart';

FichaRegistralPropietarios _$FichaRegistralPropietariosFromJson(
    Map<String, dynamic> json) {
  return FichaRegistralPropietarios()
    ..id = json['id'] as int
    ..cedRuc = json['cedRuc'] as String
    ..nombre = json['nombre'] as String
    ..selected = json['selected'] as bool;
}

Map<String, dynamic> _$FichaRegistralPropietariosToJson(
        FichaRegistralPropietarios instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cedRuc': instance.cedRuc,
      'nombre': instance.nombre,
      'selected': instance.selected
    };
