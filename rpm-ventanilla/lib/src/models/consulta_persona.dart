class ConsultaPersona {
  String? aplicacion;
  String? identificacion;

  ConsultaPersona();

  ConsultaPersona fromJson(Map<String, dynamic> json) {
    return ConsultaPersona()
      ..aplicacion = json['aplicacion'] as String? ?? null
      ..identificacion = json['identificacion'] as String? ?? null;
  }

  Map<String, dynamic> toJson(ConsultaPersona instance) => <String, dynamic>{
        'aplicacion': instance.aplicacion,
        'identificacion': instance.identificacion,
      };
}
