import 'dart:typed_data';

class ActoRequisito {
  int? id;
  int? requisitoActo;
  int? idActo;
  String? acto;
  int? idRequisito;
  String? requisito;
  int? documento;
  bool? requerido;
  String nombreArchivo = '';
  Uint8List? archivo;

  ActoRequisito();

  ActoRequisito fromJson(Map<String, dynamic> json) {
    return ActoRequisito()
      ..id = json['id'] as int? ?? null
      ..requisitoActo = json['requisitoActo'] as int? ?? null
      ..idActo = json['idActo'] as int? ?? null
      ..acto = json['acto'] as String? ?? ''
      ..idRequisito = json['idRequisito'] as int? ?? null
      ..requisito = json['requisito'] as String? ?? ''
      ..documento = json['documento'] as int? ?? null
      ..requerido = json['requerido'] as bool?;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'requisitoActo': requisitoActo,
        'idActo': idActo,
        'acto': acto,
        'idRequisito': idRequisito,
        'requisito': requisito,
        'documento': documento,
        'requerido': requerido,
        'nombreArchivo': nombreArchivo,
        'archivo': archivo,

        //'urlRp': urlRp,
      };
}
