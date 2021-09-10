

part 'balcon-servicio.g.dart';

class BalconServicio {
  String? acto;
  String? numeroFicha;
  String? fechaInscripcion;
  String? anioInscripcion;
  String? numeroInscripcion;
  String? cedula;
  String? nombres;
  String? papel;
  String? observacion;
  bool? traspasoDominio;
  bool? tieneGravamen;

  BalconServicio();

  factory BalconServicio.fromJson(Map<String, dynamic> json) =>
      _$BalconServicioFromJson(json);
}
