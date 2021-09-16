import 'dart:async';

import 'package:app/models/login_info.dart';
import 'package:app/models/users.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  CreditBloc()
      : super(CreditUpdated(
            credit: '', creditLimitEndDate: '', creditLimitStartDate: ''));

  @override
  Stream<CreditState> mapEventToState(
    CreditEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is CreditInitialization) {
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;
      yield CreditUpdated(
          credit: user.credit as String,
          creditLimitStartDate: user.creditLimitStartDate as String,
          creditLimitEndDate: user.creditLimitEndDate as String);
    } else if (event is CreditUpdate) {
      int paidAmount = event.credit;
      double credit = double.parse(state.credit);
      double result = credit - paidAmount;
      yield CreditUpdated(
          credit: result.toString(),
          creditLimitStartDate: state.creditLimitStartDate as String,
          creditLimitEndDate: state.creditLimitEndDate as String);
    }
  }
}
