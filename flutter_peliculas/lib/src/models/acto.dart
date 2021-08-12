part 'acto.g.dart';

class Acto {
  int? id;
  String? acto;
  String? uniqueId;
  String? producto;
  String? descripcion;
  String? urlImage;
  String? abrv;
  int? orden;
  double? valor;
  bool? certificadoNoPoseerBien;
  bool? tramiteBanca;
  double? valorTemp;

  Acto();

  Acto fromJson(Map<String, dynamic> json) {
    return Acto()
      ..id = json['id'] as int?
      ..acto = json['acto'] as String?
      ..uniqueId = json['uniqueId'] as String?
      ..producto = json['producto'] as String?
      ..descripcion = json['descripcion'] as String?
      ..urlImage = json['urlImage'] as String?
      ..abrv = json['abrv'] as String?
      ..orden = json['orden'] as int?
      ..valor = json['valor'] as double?
      ..certificadoNoPoseerBien = json['certificadoNoPoseerBien'] as bool?
      ..tramiteBanca = json['tramiteBanca'] as bool?
      ..valorTemp = json['valorTemp'] as double?;
  }
//factory Acto.fromJson(Map<String, dynamic> json) => _$ActoFromJson(json);

//Map<String, dynamic> toJson() => _$ActoToJson(this);
}
