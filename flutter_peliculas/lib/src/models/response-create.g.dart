
part of 'response-create.dart';

ResponseCreate _$ResponseCreateFromJson(Map<String, dynamic> json) {
  return ResponseCreate()
    ..id = json['id'] as int
    ..cardToken = json['cardToken'] as String
    ..authorizationCode = json['authorizationCode'] as String
    ..messageCode = json['messageCode'] as String
    ..status = json['status'] as String
    ..statusCode = json['statusCode'] as String
    ..transactionId = json['transactionId'] as String
    ..clientTransactionId = json['clientTransactionId'] as String;
}

Map<String, dynamic> _$ResponseCreateToJson(ResponseCreate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardToken': instance.cardToken,
      'authorizationCode': instance.authorizationCode,
      'messageCode': instance.messageCode,
      'status': instance.status,
      'statusCode': instance.statusCode,
      'transactionId': instance.transactionId,
      'clientTransactionId': instance.clientTransactionId
    };
