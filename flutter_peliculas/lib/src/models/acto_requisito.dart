class ActoRequisto {
  int? id;
  int? requisitoActo;
  int? idActo;
  String? acto;
  int? idRequisito;
  String? requisito;
  int? documento;
  bool? requerido;

  ActoRequisto();

  ActoRequisto fromJson(Map<String, dynamic> json) {
    return ActoRequisto()
      ..id = json['id'] as int? ?? null
      ..requisitoActo = json['requisitoActo'] as int? ?? null
      ..idActo = json['idActo'] as int? ?? null
      ..acto = json['acto'] as String? ?? ''
      ..idRequisito = json['idRequisito'] as int? ?? null
      ..requisito = json['requisito'] as String? ?? ''
      ..documento = json['documento'] as int? ?? null
      ..requerido = json['requerido'] as bool?;
  }
}
