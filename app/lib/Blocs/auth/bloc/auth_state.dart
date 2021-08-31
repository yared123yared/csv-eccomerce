part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//Auto Login
class AutoLoginState extends AuthState {}

class AutoLoginSuccessState extends AuthState {
   late final LoggedUserInfo user;

  AutoLoginSuccessState({required this.user});
}

class AutoLoginFailedState extends AuthState {
  AutoLoginFailedState();
}
//Login
class LoggingState extends AuthState {}

class LoginSuccessState extends AuthState {
  late final LoggedUserInfo user;
  LoginSuccessState({required this.user});
}

class LoginFailedState extends AuthState {
  late final String message;
  LoginFailedState({required this.message});
}

class UpdatingPasswordState extends AuthState {}

class UpdatingPasswordSuccessState extends AuthState {}

class UpdatingPasswordFailedState extends AuthState {
  late final String message;
  UpdatingPasswordFailedState({required this.message});
}

class SendingOtpState extends AuthState {}

class SendingOtpSuccessState extends AuthState {}

class SendingOtpFailedState extends AuthState {

  late final String message;
  SendingOtpFailedState({required this.message});
}
class ResendingOtpState extends AuthState {}

class ResendingOtpSuccessState extends AuthState {}

class ResendingOtpFailedState extends AuthState {
  late final String message;
  ResendingOtpFailedState({required this.message});
}
class ConfirmingOTPState extends AuthState {}

class ConfirmOTPSuccessState extends AuthState {}

class ConfirmOTPFailedState extends AuthState {
  late final String message;
  ConfirmOTPFailedState({required this.message});
}
