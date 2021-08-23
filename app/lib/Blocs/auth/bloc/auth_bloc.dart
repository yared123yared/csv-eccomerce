import 'dart:async';
import 'dart:io';

import 'package:app/db/db.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
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
    } else if (event is UpdatePasswordEvent) {
      yield* _mapUpdatePasswordEventToState(
        event.password,
        event.confirmedPassword,
      );
    } else if (event is SendOTPEvent) {
      yield* _mapSendOtpEventToState(event.email);
    } else if (event is ConfirmOTPEvent) {
      yield* _mapConfirmOTPEventToState(
        event.email,
        event.otp,
        event.password,
        event.confirmed_password,
      );
    }
  }

  Stream<AuthState> _mapLoginEventToState(LoginInfo user) async* {
    yield LoggingState();

    bool connected = await ConnectionChecker.CheckInternetConnection();

    try {
      if (connected) {
        LoggedUserInfo u = await userRepository.login(user);
        await CsvDatabse.instance.deleteAllClients();
        yield LoginSuccessState(user: u);
      } else {
        LoggedUserInfo? u = await userRepository.offlineLogin(user);
        if (u == null) {
          yield LoginFailedState(message: "unable to read user-credential");
          return;
        }
        yield LoginSuccessState(user: u);
      }
    } on HttpException catch (e) {
      yield LoginFailedState(message: e.message);
    } catch (e) {
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
        LoggedUserInfo? user = await this.userPreference.getUserInformation();
        if (user == null) {
          yield AutoLoginFailedState();

          return;
        }
        yield AutoLoginSuccessState(user: user as LoggedUserInfo);
      }
    } catch (e) {
      yield AutoLoginFailedState();
    }
  }

  Stream<AuthState> _mapUpdatePasswordEventToState(
      String password, confirmedPassword) async* {
    yield UpdatingPasswordState();
    try {
      await userRepository.updatepassword(password, confirmedPassword);
      yield UpdatingPasswordSuccessState();
    } on HttpException catch (e) {
      print(e.message);
      yield UpdatingPasswordFailedState(message: e.message);
    } catch (e) {
      print(e.toString());
      yield UpdatingPasswordFailedState(message: 'Login Failed');
    }
  }

  Stream<AuthState> _mapSendOtpEventToState(String email) async* {
    yield SendingOtpState();
    print("Sending otp");
    try {
      await userRepository.sendOtp(email);
      yield SendingOtpSuccessState();

      print("Send otp");
    } on HttpException catch (e) {
      print(e.message);
      print("error http otp");

      yield SendingOtpFailedState(message: e.message);
    } catch (e) {
      print("Sending otp");

      print(e.toString());
      yield SendingOtpFailedState(message: 'Send Otp Failed');
    }
  }

  Stream<AuthState> _mapConfirmOTPEventToState(
      String email, otp, password, confirmedPassword) async* {
    yield ConfirmingOTPState();
    print("confirming ");

    try {
      await userRepository.changePassword(
          email, otp, password, confirmedPassword);
      yield ConfirmOTPSuccessState();
      print("confirm succesa");
    } on HttpException catch (e) {
      print("confirm http error");

      print(e.message);
      yield ConfirmOTPFailedState(message: e.message);
    } catch (e) {
      print("confirm otp");

      print(e.toString());
      yield ConfirmOTPFailedState(message: 'Confirm OTP failed');
    }
  }
}
