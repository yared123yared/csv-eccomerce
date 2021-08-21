part of 'payment_bloc.dart';

class PaymentState {
  final Payment payment;
  PaymentState({required this.payment});
}

class PaymentInitial extends PaymentState {
  PaymentInitial() : super(payment: Payment());
}

class PaymentUpdatedSucess extends PaymentState {
  final Payment payment;
  PaymentUpdatedSucess({required this.payment}) : super(payment: payment);
}
