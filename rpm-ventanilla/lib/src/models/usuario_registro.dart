class UsuarioRegistro {
  String? identificacion;
  String? fechaExpedicion;
  String? nombresCompletos;
  String? celular;
  String? clave;

  UsuarioRegistro();

  UsuarioRegistro fromJson(Map<String, dynamic> json) {
    return UsuarioRegistro()
      ..identificacion = json['identificacion'] as String? ?? null
      ..fechaExpedicion = json['fechaExpedicion'] as String? ?? null
      ..nombresCompletos = json['nombresCompletos'] as String? ?? null
      ..celular = json['celular'] as String? ?? null
      ..clave = json['clave'] as String? ?? null;
  }

  Map<String, dynamic> toJson(UsuarioRegistro instance) => <String, dynamic>{
        'identificacion': instance.identificacion,
        'fechaExpedicion': instance.fechaExpedicion,
        'nombresCompletos': instance.nombresCompletos,
        'celular': instance.celular,
        'clave': instance.clave,
      };
}
