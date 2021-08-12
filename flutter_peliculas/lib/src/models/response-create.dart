
part 'response-create.g.dart';

class ResponseCreate {
  int? id;
  String? cardToken;
  String? authorizationCode;
  String? messageCode;
  String? status;
  String? statusCode;
  String? transactionId;
  String? clientTransactionId;

  ResponseCreate();

  factory ResponseCreate.fromJson(Map<String, dynamic> json) =>
      _$ResponseCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCreateToJson(this);

}
