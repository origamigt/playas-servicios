
part of 'comentarios-sugerencias.dart';

ComentariosSugerencias _$ComentariosSugerenciasFromJson(
    Map<String, dynamic> json) {
  return ComentariosSugerencias(
      json['id'] as int, json['textComentario'] as String, json['user'] as int)
    ..fecha =
        json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String);
}

Map<String, dynamic> _$ComentariosSugerenciasToJson(
        ComentariosSugerencias instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fecha': instance.fecha?.toIso8601String(),
      'textComentario': instance.textComentario,
      'user': instance.user
    };
