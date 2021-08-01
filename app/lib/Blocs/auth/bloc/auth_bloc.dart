import 'dart:async';
import 'dart:io';

import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/login_info.dart';
import '../../../repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final UserRepository userRepository;
  late final UserPreferences userPreference;

  AuthBloc({
    required this.userRepository,
    required this.userPreference,
  }) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginEventToState(event.user);
    } else if (event is AutoLoginEvent) {
      yield* _mapAutoLoginEventToState();
    }
  }

  Stream<AuthState> _mapLoginEventToState(LoginInfo user) async* {
    yield LoggingState();
    LoggedUserInfo u;
    try {
      u = await userRepository.login(user);
      yield LoginSuccessState(user: u);
      print('0---------');
      print(u);
    } on HttpException catch (e) {
      print('1------------------');
      print(e.message);
      yield LoginFailedState(message: e.message);
    } catch (e) {
      print('2------------------');
      print(e.toString());
      yield LoginFailedState(message: 'Login Failed');
    }
  }

  Stream<AuthState> _mapAutoLoginEventToState() async* {
    yield AutoLoginState();
    try {
      String? token = await this.userPreference.getUserToken();
      if (token == null) {
        yield AutoLoginFailedState();
        return;
      }
      String? expiry = await this.userPreference.getExpiryTime();
      if (expiry == null) {
        yield AutoLoginFailedState();
        return;
      }
      bool isExpired = this.userPreference.isExpired(expiry);
      if (isExpired) {
        yield AutoLoginFailedState();
        return;
      } else {
        LoggedUserInfo user = await this.userPreference.getUserInformation();
        yield AutoLoginSuccessState(user: user);
      }
    } catch (e) {
      yield AutoLoginFailedState();
    }
  }
}
