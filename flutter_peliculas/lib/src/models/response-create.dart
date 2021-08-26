part 'response-create.g.dart';

class ResponseCreate {
  int? id;
  String? cardToken;
  String? authorizationCode;
  String? messageCode;
  String? message;
  String? status;
  String? statusCode;
  String? transactionId;
  String? clientTransactionId;
  String? acto;
  double? total;

  ResponseCreate();

  factory ResponseCreate.fromJson(Map<String, dynamic> json) =>
      _$ResponseCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCreateToJson(this);

  @override
  String toString() {
    return 'ResponseCreate{id: $id, cardToken: $cardToken, authorizationCode: $authorizationCode, messageCode: $messageCode, message: $message, status: $status, statusCode: $statusCode, transactionId: $transactionId, clientTransactionId: $clientTransactionId, acto: $acto, total: $total}';
  }
}
