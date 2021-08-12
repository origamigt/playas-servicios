
part 'bancos.g.dart';

class Bancos {

  int? id;
  String? banco;

  Bancos();

  factory Bancos.fromJson(Map<String, dynamic> json) => _$BancosFromJson(json);


}