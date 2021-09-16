import 'dart:core';

import 'package:playas/src/models/usuario_registro.dart';

class CodigoVerificacion {
  int? id;
  String? codigo;
  String? correo;
  bool? validado;
  String? persona;
  String? identificacion;
  UsuarioRegistro? usuarioRegistro;

  //String urlRp;

  CodigoVerificacion();

  CodigoVerificacion fromJson(Map<String, dynamic> json) {
    return CodigoVerificacion()
      ..id = json['id'] as int? ?? null
      ..codigo = json['codigo'] as String? ?? null
      ..correo = json['correo'] as String? ?? null
      ..validado = json['validado'] as bool? ?? null
      ..persona = json['persona'] as String? ?? null
      ..identificacion = json['identificacion'] as String? ?? null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'codigo': codigo,
        'correo': correo,
        'validado': validado,
        'persona': persona,
        'identificacion': identificacion,
      };

  Map<String, dynamic> json(CodigoVerificacion instance) => <String, dynamic>{
        'id': instance.id,
        'codigo': instance.codigo,
        'correo': instance.correo,
        'validado': instance.validado,
        'persona': instance.persona,
        'identificacion': instance.identificacion,
      };

  Map<String, dynamic> jsonRegistro(CodigoVerificacion instance) =>
      <String, dynamic>{
        'id': instance.id,
        'codigo': instance.codigo,
        'correo': instance.correo,
        'validado': instance.validado,
        'persona': instance.persona,
        'identificacion': instance.identificacion,
        'usuarioRegistro': instance.usuarioRegistro,
      };
}
