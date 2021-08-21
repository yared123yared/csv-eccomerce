part of 'payment_bloc.dart';

class PaymentState {
  final Payment? payment;
  PaymentState({this.payment});
}

class PaymentInitial extends PaymentState {
  PaymentInitial() : super();
}

class PaymentUpdatedSucess extends PaymentState {
  final Payment payment;
  PaymentUpdatedSucess({required this.payment});
}
