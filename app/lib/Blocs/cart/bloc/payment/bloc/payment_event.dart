part of 'payment_bloc.dart';

class PaymentEvent {
  const PaymentEvent();
}

// class UpdatePaymentEvent extends PaymentEvent {
//   final Payment payment;
//   UpdatePaymentEvent({required this.payment});
// }

class AddPaymentWhenEvent extends PaymentEvent {
  final String when;
  AddPaymentWhenEvent({required this.when});
}

class AddPaymentMethodEvent extends PaymentEvent {
  final String method;
  AddPaymentMethodEvent({required this.method});
}

class AddPaymentTypeEvent extends PaymentEvent {
  final String type;
  AddPaymentTypeEvent({required this.type});
}

class AddTransactionIdEvent extends PaymentEvent {
  final String transactionId;
  AddTransactionIdEvent({required this.transactionId});
}

class AddPaidAmountEvent extends PaymentEvent {
  final int amount;
  AddPaidAmountEvent({required this.amount});
}

class AddRemainingAmountEvent extends PaymentEvent {
  final int amount;
  AddRemainingAmountEvent({required this.amount});
}
