import 'dart:async';

import 'package:app/data_provider/reports/custom_debt_data_provider.dart';
import 'package:app/models/repoets_model/custom_report_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_debt_event.dart';
part 'custom_debt_state.dart';

class CustomDebtBloc extends Bloc<CustomDebtEvent, CustomDebtState> {
  final CustomDebtDataProvider customDebtDataProvider;
  CustomDebtBloc(this.customDebtDataProvider) : super(CustomDebtInitial());

  @override
  Stream<CustomDebtState> mapEventToState(
    CustomDebtEvent event,
  ) async* {
    if (event is CustomDebtEvent) {
      yield CustomDebtLoadingState();
      try {
        var customDebt = await customDebtDataProvider.getCustomReport();
        yield CustomDebtSuccessState(customDebt);
      } catch (e) {
        yield CustomDebtErrorState(e.toString());
      }
    }
  }
}
