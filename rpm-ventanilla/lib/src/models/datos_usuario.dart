class DatosUsuario {
  String? cedula;
  String? nombre;
  String? apellido;
  String? institucion = "";
  String? cargo = "";
  String? serial;
  String? fechaFirmaArchivo;
  String? entidadCertificadora;
  bool? selladoTiempo;
  bool? certificadoDigitalValido;

  DatosUsuario();

  DatosUsuario fromJson(Map<String, dynamic> json) {
    return DatosUsuario()
      ..cedula = json['cedula'] as String? ?? null
      ..nombre = json['nombre'] as String? ?? null
      ..apellido = json['apellido'] as String? ?? null
      ..institucion = json['institucion'] as String? ?? null
      ..cargo = json['cargo'] as String? ?? null
      ..serial = json['serial'] as String? ?? null
      ..fechaFirmaArchivo = json['fechaFirmaArchivo'] as String? ?? null
      ..entidadCertificadora = json['entidadCertificadora'] as String? ?? null
      ..selladoTiempo = json['selladoTiempo'] as bool? ?? null
      ..certificadoDigitalValido =
          json['certificadoDigitalValido'] as bool? ?? null;
  }
}
