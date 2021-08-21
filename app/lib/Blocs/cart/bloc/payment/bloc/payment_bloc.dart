import 'dart:async';

import 'package:app/models/request/payment.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial());

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    yield PaymentInitial();
    if (event is AddPaymentWhenEvent) {
      print("Entered to the payment bloc");
      print(state.payment.toJson());
      Payment payment = state.payment as Payment;
      payment.PaymentWhen = event.when;
      print("When:${event.when}");
      print("updated payment:${payment.toJson()}");
      yield PaymentUpdatedSucess(payment: payment);
    } else if (event is AddPaymentMethodEvent) {
      print("Entered to the payment bloc");
      print(state.payment);
      Payment payment = state.payment as Payment;
      payment.PaymentMethod = event.method;
      yield PaymentUpdatedSucess(payment: payment);
    } else if (event is AddPaymentTypeEvent) {
      print("Entered to the payment bloc");
      print(state.payment);
      Payment payment = state.payment as Payment;
      payment.TypeOfWallet = event.type;
      yield PaymentUpdatedSucess(payment: payment);
    } else if (event is AddTransactionIdEvent) {
      print("Entered to the payment bloc");
      print(state.payment);
      Payment payment = state.payment as Payment;
      payment.TransactionId = event.transactionId;
      yield PaymentUpdatedSucess(payment: payment);
    } else if (event is AddPaidAmountEvent) {
      print("Entered to the payment bloc");
      print(state.payment);
      Payment payment = state.payment as Payment;
      payment.AmountPaid = event.amount;
      yield PaymentUpdatedSucess(payment: payment);
    } else if (event is AddRemainingAmountEvent) {
      print("Entered to the payment bloc");
      print(state.payment);
      Payment payment = state.payment as Payment;
      payment.AmountRemaining = event.amount;
      yield PaymentUpdatedSucess(payment: payment);
    }
  }
}
