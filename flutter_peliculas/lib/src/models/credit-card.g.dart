
part of 'credit-card.dart';

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return CreditCard(
      json['cardNumber'] as String,
      json['expiryDate'] as String,
      json['holderName'] as String,
      json['securityCode'] as String,
      json['idSolicitud'] as int,
      json['tipoTransaccion'] as String,
      json['idUser'] as int);
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'holderName': instance.holderName,
      'securityCode': instance.securityCode,
      'idSolicitud': instance.idSolicitud,
      'idUser': instance.idUser,
      'tipoTransaccion': instance.tipoTransaccion
    };
