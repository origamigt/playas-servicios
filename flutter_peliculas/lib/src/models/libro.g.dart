// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Libro _$LibroFromJson(Map<String, dynamic> json) {
  return Libro()
    ..id = json['id'] as int
    ..nombre = json['nombre'] as String
    ..imagenLibro = json['imagenLibro'] as String;
}

Map<String, dynamic> _$LibroToJson(Libro instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'imagenLibro': instance.imagenLibro
    };
