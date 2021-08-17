
part of 'balcon-servicio.dart';

BalconServicio _$BalconServicioFromJson(Map<String, dynamic> json) {
  return BalconServicio()
    ..acto = json['acto'] as String
    ..numeroFicha = json['numeroFicha'] as String
    ..fechaInscripcion = json['fechaInscripcion'] as String
    ..anioInscripcion = json['anioInscripcion'] as String
    ..numeroInscripcion = json['numeroInscripcion'] as String
    ..cedula = json['cedula'] as String
    ..nombres = json['nombres'] as String
    ..papel = json['papel'] as String
    ..observacion = json['observacion'] as String
    ..traspasoDominio = json['traspasoDominio'] as bool
    ..tieneGravamen = json['tieneGravamen'] as bool;
}

Map<String, dynamic> _$BalconServicioToJson(BalconServicio instance) =>
    <String, dynamic>{
      'acto': instance.acto,
      'numeroFicha': instance.numeroFicha,
      'fechaInscripcion': instance.fechaInscripcion,
      'anioInscripcion': instance.anioInscripcion,
      'numeroInscripcion': instance.numeroInscripcion,
      'cedula': instance.cedula,
      'nombres': instance.nombres,
      'papel': instance.papel,
      'observacion': instance.observacion,
      'traspasoDominio': instance.traspasoDominio,
      'tieneGravamen': instance.tieneGravamen
    };
