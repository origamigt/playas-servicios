part of 'persona.dart';

PubPersona _$PubPersonaFromJson(Map<String, dynamic> json) {
  print(json);
  return PubPersona()
    ..id = json['id'] ?? json['id'] as int
    ..cedRuc = json['cedRuc'] ?? json['cedRuc'] as String
    ..nombres = json['nombres'] ?? json['nombres'] as String
    ..apellidos = json['apellidos'] ?? json['apellidos'] as String
    ..tipoDocumento = json['tipoDocumento'] ?? json['tipoDocumento'] as String
    ..tipoPersona = json['tipoPersona'] ?? json['tipoPersona'] as String
    ..fechaCreacion = json['fechaCreacion'] ?? json['fechaCreacion'] as int
    ..fechaNacimiento =
        json['fechaNacimiento'] ?? json['fechaNacimiento'] as int
    ..fechaNacimientoLong =
        json['fechaNacimientoLong'] ?? json['fechaNacimientoLong'] as int
    ..fechaExpedicionLong =
        json['fechaNacimientoLong'] ?? json['fechaNacimientoLong'] as int
    ..direccion = json['direccion'] ?? json['direccion'] as String
    ..telefono1 = json['telefono1'] ?? json['telefono1'] as String
    ..telefono2 = json['telefono2'] ?? json['telefono2'] as String
    ..correo1 = json['correo1'] ?? json['correo1'] as String
    ..correoCodificado = json['correoCodificado'] as String
    ..estado = json['estado'] as bool
    ..usuario = json['usuario'] ??
        User().fromJson(json['usuario'] as Map<String, dynamic>)
    ..estadoCivil = json['estadoCivil'] ?? json['estadoCivil'] as String
    ..tipoPersonaWs = json['tipoPersonaWs'] ?? json['tipoPersonaWs'] as int
    ..numeroCasa = json['numeroCasa'] ?? json['numeroCasa'] as String
    ..nombreConyuge = json['nombreConyuge'] ?? json['nombreConyuge'] as String
    ..apellidoConyuge =
        json['apellidoConyuge'] ?? json['apellidoConyuge'] as String;
}

Map<String, dynamic> _$PubPersonaToJson(PubPersona instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cedRuc': instance.cedRuc,
      'nombres': instance.nombres,
      'apellidos': instance.apellidos,
      'tipoDocumento': instance.tipoDocumento,
      'tipoPersona': instance.tipoPersona,
      'fechaCreacion': instance.fechaCreacion,
      'fechaNacimiento': instance.fechaNacimiento,
      'fechaNacimientoLong': instance.fechaNacimientoLong,
      'fechaExpedicionLong': instance.fechaExpedicionLong,
      'direccion': instance.direccion,
      'telefono1': instance.telefono1,
      'telefono2': instance.telefono2,
      'correo1': instance.correo1,
      'correoCodificado': instance.correoCodificado,
      'estado': instance.estado,
      'usuario': instance.usuario,
      'estadoCivil': instance.estadoCivil,
      'tipoPersonaWs': instance.tipoPersonaWs,
      'numeroCasa': instance.numeroCasa,
      'nombreConyuge': instance.nombreConyuge,
      'apellidoConyuge': instance.apellidoConyuge
    };
