
part 'comentarios-sugerencias.g.dart';

class ComentariosSugerencias {
  int? id;
  DateTime? fecha;
  String textComentario;
  int? user;

  ComentariosSugerencias(this.id, this.textComentario, this.user);

  factory ComentariosSugerencias.fromJson(Map<String, dynamic> json) =>
      _$ComentariosSugerenciasFromJson(json);

  Map<String, dynamic> toJson() => _$ComentariosSugerenciasToJson(this);
}
