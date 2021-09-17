import 'dart:async';

import 'package:app/models/login_info.dart';
import 'package:app/models/users.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/repository/credit_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  final CreditRepository creditRepository;
  CreditBloc({required this.creditRepository})
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
      yield CreditUpdateLoading();
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;

      User updatedUserInfo =
          await this.creditRepository.UpdateUserInformation(user.id as int);

      yield CreditUpdated(
          credit: updatedUserInfo.credit.toString(),
          creditLimitStartDate: updatedUserInfo.creditLimitStartDate as String,
          creditLimitEndDate: updatedUserInfo.creditLimitEndDate as String);
    }
  }
}
