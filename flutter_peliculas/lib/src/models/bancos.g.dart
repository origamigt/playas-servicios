// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bancos.dart';

Bancos _$BancosFromJson(Map<String, dynamic> json) {
  return Bancos()
    ..id = json['id'] as int
    ..banco = json['banco'] as String;
}

Map<String, dynamic> _$BancosToJson(Bancos instance) =>
    <String, dynamic>{'id': instance.id, 'banco': instance.banco};
