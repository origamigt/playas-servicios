import 'dart:typed_data';

class UsuarioRegistro {
  int? personaId;
  String? identificacion;
  String? fechaExpedicion;
  String? nombresCompletos;
  String? direccion;
  String? celular;
  String? clave;
  String? correo;
  String? correoCodificado;
  bool? creado;
  Uint8List? archivo;
  String? tipo;

  UsuarioRegistro();

  UsuarioRegistro fromJson(Map<String, dynamic> json) {
    return UsuarioRegistro()
      ..personaId = json['personaId'] as int? ?? null
      ..identificacion = json['identificacion'] as String? ?? null
      ..fechaExpedicion = json['fechaExpedicion'] as String? ?? null
      ..nombresCompletos = json['nombresCompletos'] as String? ?? null
      ..direccion = json['direccion'] as String? ?? null
      ..celular = json['celular'] as String? ?? null
      ..clave = json['clave'] as String? ?? null
      ..correo = json['correo'] as String? ?? null
      ..tipo = json['tipo'] as String? ?? null
      ..creado = json['creado'] as bool? ?? null
      ..correoCodificado = json['correoCodificado'] as String? ?? null;
  }

  Map<String, dynamic> json(UsuarioRegistro instance) => <String, dynamic>{
        'personaId': instance.personaId,
        'identificacion': instance.identificacion,
        'fechaExpedicion': instance.fechaExpedicion,
        'nombresCompletos': instance.nombresCompletos,
        'direccion': instance.direccion,
        'celular': instance.celular,
        'clave': instance.clave,
        'correo': instance.correo,
        'creado': instance.creado,
        'correoCodificado': instance.correoCodificado,
        'archivo': instance.archivo,
        'tipo': instance.tipo,
      };

  Map<String, dynamic> toJson() => {
        'personaId': personaId,
        'identificacion': identificacion,
        'fechaExpedicion': fechaExpedicion,
        'nombresCompletos': nombresCompletos,
        'direccion': direccion,
        'celular': celular,
        'clave': clave,
        'correo': correo,
        'creado': creado,
        'correoCodificado': correoCodificado,
        'archivo': archivo,
        'tipo': tipo,
      };
}
