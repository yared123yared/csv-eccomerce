class Payment {
  String? PaymentWhen;
  String? PaymentMethod;
  String? TransactionId;
  int? AmountPaid;
  int? AmountRemaining;
  String? TypeOfWallet;

  Payment(
      {this.AmountPaid,
      this.PaymentMethod,
      this.AmountRemaining,
      this.PaymentWhen,
      this.TypeOfWallet,
      this.TransactionId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentWhen'] = this.PaymentWhen;
    data['paymentMethod'] = this.PaymentMethod;
    data['transaction_Id'] = this.TransactionId;
    data['amountPaid'] = this.AmountPaid;
    data['amountRemainign'] = this.AmountRemaining;
    data['type_of_wallet'] = this.TypeOfWallet;

    return data;
  }
}
