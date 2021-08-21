class Payment {
   String PaymentWhen;
   String PaymentMethod;
   String TransactionId;
   int AmountPaid;
   int AmountRemaining;
   String TypeOfWallet;

  Payment(
      {required this.AmountPaid,
      required this.PaymentMethod,
      required this.AmountRemaining,
      required this.PaymentWhen,
      required this.TypeOfWallet,
      required this.TransactionId});
}
