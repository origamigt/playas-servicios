
part 'credit-card.g.dart';

class CreditCard {
  String cardNumber;
  String expiryDate;
  String holderName;
  String securityCode;
  int idSolicitud;
  int idUser;
  String tipoTransaccion;

  CreditCard(this.cardNumber, this.expiryDate, this.holderName,
      this.securityCode, this.idSolicitud, this.tipoTransaccion, this.idUser);


  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardToJson(this);

}
