class Data {
  String? data;
  int? id;

  Data();

  Data fromJson(Map<String, dynamic> json) {
    return Data()
      ..data = json['data'] as String? ?? null
      ..id = json['id'] as int? ?? null;
  }

  Data initData(int? id, String? data) {
    return Data()
      ..data = data
      ..id = id;
  }

  Map<String, dynamic> toJson(Data instance) => <String, dynamic>{
        'data': instance.data,
        'id': instance.id,
      };
}
