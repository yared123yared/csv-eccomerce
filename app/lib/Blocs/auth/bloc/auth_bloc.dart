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
    } else if (event is ResendOTPEvent) {
      yield* _mapReSendOtpEventToState(event.email);
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
        await this.userPreference.logOut(false);
        yield LoginSuccessState(user: u);
      } else {
        LoggedUserInfo? u = await userRepository.offlineLogin(user);
        if (u == null) {
          yield LoginFailedState(message: "unable to read user-credential");
          return;
        }
        await this.userPreference.logOut(false);
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
      print("auto login 0");
      bool? isLoggedOut = await this.userPreference.IsLoggedOut();
      if (isLoggedOut == null) {
        yield AutoLoginFailedState();
        return;
      }
      if (isLoggedOut == true) {
        yield AutoLoginFailedState();
        return;
      }

      print(" auto log 1");
      String? token = await this.userPreference.getUserToken();
      if (token == null) {
        yield AutoLoginFailedState();
        return;
      }
      print(" auto log 2");

      String? expiry = await this.userPreference.getExpiryTime();
      if (expiry == null) {
        yield AutoLoginFailedState();
        return;
      }
      print(" auto log 3");

      print("expiry--${expiry}");
      bool isExpired = this.userPreference.isExpired(expiry);
      if (isExpired) {
        print(" auto log 4");

        yield AutoLoginFailedState();
        return;
      } else {
        print(" auto log 5");

        LoggedUserInfo? user = await this.userPreference.getUserInformation();
        if (user == null) {
          yield AutoLoginFailedState();
          return;
        }
        yield AutoLoginSuccessState(user: user);
      }
    } catch (e) {
      print("--bloc--error auto login");
      print(e.toString());
      yield AutoLoginFailedState();
    }
  }

  Stream<AuthState> _mapUpdatePasswordEventToState(
      String password, confirmedPassword) async* {
    yield UpdatingPasswordState();
    try {
      await userRepository.updatepassword(password, confirmedPassword);
      yield UpdatingPasswordSuccessState();
      return;
    } on HttpException catch (e) {
      print(e.message);
      yield UpdatingPasswordFailedState(message: e.message);
      return;
    } catch (e) {
      print(e.toString());
      yield UpdatingPasswordFailedState(message: 'Login Failed');
      return;
    }
  }

  Stream<AuthState> _mapSendOtpEventToState(String email) async* {
    yield SendingOtpState();
    print("Sending otp");
    try {
      await userRepository.sendOtp(email);
      yield SendingOtpSuccessState();

      print("Send otp");
      return;
    } on HttpException catch (e) {
      print(e.message);
      print("error http otp");

      yield SendingOtpFailedState(message: e.message);
      return;
    } catch (e) {
      print("Sending otp");

      print(e.toString());
      yield SendingOtpFailedState(message: 'Send Otp Failed');
      return;
    }
  }

  Stream<AuthState> _mapReSendOtpEventToState(String email) async* {
    yield ResendingOtpState();
    print("Resending otp");
    try {
      await userRepository.sendOtp(email);
      yield ResendingOtpSuccessState();

      print("ReSend otp");
      return;
    } on HttpException catch (e) {
      print(e.message);
      print("error http otp resend");

      yield ResendingOtpFailedState(message: e.message);
      return;
    } catch (e) {
      print("resending otp");

      print(e.toString());
      yield ResendingOtpFailedState(message: 'resend Otp Failed');
      return;
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
      return;
    } on HttpException catch (e) {
      print("confirm http error");

      print(e.message);
      yield ConfirmOTPFailedState(message: e.message);
      return;
    } catch (e) {
      print("confirm otp");

      print(e.toString());
      yield ConfirmOTPFailedState(message: 'Confirm OTP failed');
      return;
    }
  }
}
