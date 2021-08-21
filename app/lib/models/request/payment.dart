class Payment {
  final String PaymentWhen;
  final String PaymentMethod;
  final String TransactionId;
  final int AmountPaid;
  final int AmountRemaining;
  final String TypeOfWallet;

  Payment(
      {required this.AmountPaid,
      required this.PaymentMethod,
      required this.AmountRemaining,
      required this.PaymentWhen,
      required this.TypeOfWallet,
      required this.TransactionId});
}
