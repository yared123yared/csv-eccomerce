part of 'payment_bloc.dart';

class PaymentEvent {
  const PaymentEvent();
}

class UpdatePaymentEvent extends PaymentEvent {
  final Payment payment;
  UpdatePaymentEvent({required this.payment});
}
