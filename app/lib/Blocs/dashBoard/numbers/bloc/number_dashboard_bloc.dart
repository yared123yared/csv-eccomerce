import 'dart:async';

import 'package:app/data_provider/dashboard/numbers_data_provider.dart';
import 'package:app/models/dashboard/number_dashBoard_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'number_dashboard_event.dart';
part 'number_dashboard_state.dart';

class NumberDashboardBloc
    extends Bloc<NumberDashboardEvent, NumberDashboardState> {
  final NumbersDataProvider numbersDataProvider;
  NumberDashboardBloc(this.numbersDataProvider)
      : super(NumberDashboardInitial());

  @override
  Stream<NumberDashboardState> mapEventToState(
    NumberDashboardEvent event,
  ) async* {
    if (event is FeatchNumberDashevent) {
      yield NumberDashLoadingState();
      try {
        var numberdash = await numbersDataProvider.getNumberDashBord();
        yield NumberDashSuccessState(
          numberdash,
        );
      } catch (e) {
        yield NumberDashErrorState(e.toString());
      }
    }
  }
}
