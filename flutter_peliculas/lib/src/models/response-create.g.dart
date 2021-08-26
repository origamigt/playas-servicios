part of 'response-create.dart';

ResponseCreate _$ResponseCreateFromJson(Map<String, dynamic> json) {
  return ResponseCreate()
    ..id = json['id'] as int? ?? null
    ..cardToken = json['cardToken'] as String? ?? ''
    ..authorizationCode = json['authorizationCode'] as String? ?? 'null'
    ..messageCode = json['messageCode'] as String? ?? 'null'
    ..message = json['message'] as String? ?? 'null'
    ..status = json['status'] as String? ?? 'null'
    ..statusCode = json['statusCode'] as String? ?? 'null'
    ..transactionId = json['transactionId'] as String? ?? 'null'
    ..clientTransactionId = json['clientTransactionId'] as String? ?? 'null'
    ..acto = json['acto'] as String? ?? 'null'
    ..total = json['total'] as double? ?? 0;
}

Map<String, dynamic> _$ResponseCreateToJson(ResponseCreate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardToken': instance.cardToken,
      'authorizationCode': instance.authorizationCode,
      'messageCode': instance.messageCode,
      'message': instance.message,
      'status': instance.status,
      'statusCode': instance.statusCode,
      'transactionId': instance.transactionId,
      'clientTransactionId': instance.clientTransactionId,
      'acto': instance.acto,
      'total': instance.total
    };
