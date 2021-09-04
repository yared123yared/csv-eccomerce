import 'dart:async';

import 'package:app/data_provider/payments/payment_data_provider.dart';
import 'package:app/models/payment/payment_container_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bankslip_event.dart';
part 'bankslip_state.dart';

class BankslipBloc extends Bloc<BankslipEvent, BankslipState> {
  final PaymentDataProvider paymentDataProvider;
  BankslipBloc(this.paymentDataProvider) : super(BankslipInitial());

  @override
  Stream<BankslipState> mapEventToState(
    BankslipEvent event,
  ) async* {
    if (event is FeatchBankslipEvent) {
      yield BankslipLoadingState();
      try {
        final bankSlip = await paymentDataProvider.getPayMentConatiner();
        yield BankslipSuccessState(bankSlip);
      } catch (e) {
        yield BankslipErrorState(e.toString());
      }
    } else if (event is SearchBankslipEvent) {
      yield SearchBankslipLoadingState();
      try {
        final searchBankSlip = await paymentDataProvider
            .getSearchPayMentConatiner(event.searchAmount);
        yield SearchBankslipSuccessState(searchBankSlip);
      } catch (e) {
        yield BankslipErrorState(e.toString());
      }
    }
  }
}
