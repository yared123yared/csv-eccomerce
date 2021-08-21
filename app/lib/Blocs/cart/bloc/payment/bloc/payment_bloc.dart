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
    if (event is UpdatePaymentEvent) {
      print("Entered to the payment bloc");
      print(state.payment);
      yield PaymentUpdatedSucess(payment: event.payment);
    }
  }
}
