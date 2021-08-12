import 'user.dart';

part 'pub-persona.g.dart';

class PubPersona {
  int? id;
  String? cedRuc;
  String? nombres;
  String? apellidos;
  String? tipoDocumento;
  String? tipoPersona;
  int? fechaCreacion;
  int? fechaNacimiento;
  int? fechaNacimientoLong;
  int? fechaExpedicionLong;
  String? direccion;

  //celular
  String? telefono1;

  //telefono
  String? telefono2;
  String? correo1;
  String? correoCodificado;
  bool? estado = true;
  User? usuario;
  String? estadoCivil;
  int? tipoPersonaWs;
  String? numeroCasa;
  String? nombreConyuge;
  String? apellidoConyuge;

  PubPersona();

  factory PubPersona.fromJson(Map<String, dynamic> json) =>
      _$PubPersonaFromJson(json);

  PubPersona fromJson(Map<String, dynamic> json) {
    return PubPersona()
      ..id = json['id'] as int? ?? null
      ..cedRuc = json['cedRuc'] as String? ?? null
      ..nombres = json['nombres'] as String? ?? null
      ..apellidos = json['apellidos'] as String? ?? null
      ..tipoDocumento = json['tipoDocumento'] as String? ?? null
      ..tipoPersona = json['tipoPersona'] as String? ?? null
      ..fechaCreacion = json['fechaCreacion'] as int? ?? null
      ..fechaNacimiento = json['fechaNacimiento'] as int? ?? null
      ..fechaNacimientoLong = json['fechaNacimientoLong'] as int? ?? null
      ..fechaExpedicionLong = json['fechaNacimientoLong'] as int? ?? null
      ..direccion = json['direccion'] as String? ?? null
      ..telefono1 = json['telefono1'] as String? ?? null
      ..telefono2 = json['telefono2'] as String? ?? null
      ..correo1 = json['correo1'] as String? ?? null
      ..correoCodificado = json['correoCodificado'] as String? ?? null
      ..estado = json['estado'] as bool? ?? null
      ..usuario = json['usuario'] == null
          ? null
          : User().fromJson(json['usuario'] as Map<String, dynamic>)
      ..estadoCivil = json['estadoCivil'] as String? ?? null
      ..tipoPersonaWs = json['tipoPersonaWs'] as int? ?? null
      ..numeroCasa = json['numeroCasa'] as String? ?? null
      ..nombreConyuge = json['nombreConyuge'] as String? ?? null
      ..apellidoConyuge = json['apellidoConyuge'] as String? ?? null;
  }

  Map<String, dynamic> toJson() => _$PubPersonaToJson(this);

  Map<String, dynamic> json(PubPersona p) => _$PubPersonaToJson(p);
}
