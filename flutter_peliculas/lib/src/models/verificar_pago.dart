class VerificarPago {
  String? id;
  String? clientTxId;

  VerificarPago();

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientTxId': clientTxId,

        //'urlRp': urlRp,
      };
}
