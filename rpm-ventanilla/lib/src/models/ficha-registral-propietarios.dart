

part 'ficha-registral-propietarios.g.dart';

class FichaRegistralPropietarios{

  int? id;
  String? cedRuc;
  String? nombre;
  bool? selected;

  FichaRegistralPropietarios();

  factory FichaRegistralPropietarios.fromJson(Map<String, dynamic> json) =>
    _$FichaRegistralPropietariosFromJson(json);


}