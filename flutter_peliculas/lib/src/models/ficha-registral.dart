import 'package:playas/src/models/ficha-registral-propietarios.dart';

part 'ficha-registral.g.dart';

class FichaRegistral {
  int? id;
  int? numFicha;
  String? tipoInmueble;
  String? claveCatastral;
  String? parroquia;
  String? sector;
  String? manazana;
  String? lote;
  String? solNumeroCasa;
  bool? excedentePropietarios;
  List<FichaRegistralPropietarios>? fichaPropietarios;

  FichaRegistral();

  factory FichaRegistral.fromJson(Map<String, dynamic> json) =>
      _$FichaRegistralFromJson(json);
}
