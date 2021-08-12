
part 'libro.g.dart';

class Libro {

  int? id;
  String? nombre;
  String? imagenLibro;
  //List<Acto> actos;

  Libro();

  factory Libro.fromJson(Map<String, dynamic> json) => _$LibroFromJson(json);

  Map<String, dynamic> toJson() => _$LibroToJson(this);


}