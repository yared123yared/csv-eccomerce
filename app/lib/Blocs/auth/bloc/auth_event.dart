part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  late final LoginInfo user;
  LoginEvent({required this.user});

  List<Object> get props => [];
}


class AutoLoginEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UpdatePasswordEvent extends AuthEvent {
  late final String password;
  late final String confirmedPassword;
  UpdatePasswordEvent({
    required this.password,
    required this.confirmedPassword,
  });

  List<Object> get props => [];
}

class SendOTPEvent extends AuthEvent {
  late final String email;
  SendOTPEvent({required this.email});
  @override
  List<Object> get props => [];
}

class ResendOTPEvent extends AuthEvent {
  late final String email;
  ResendOTPEvent({required this.email});
  @override
  List<Object> get props => [];
}


class ConfirmOTPEvent extends AuthEvent {
  late final String email;
  late final String otp;
  late final String password;
  late final String confirmed_password;
  ConfirmOTPEvent({
    required this.email,
    required this.otp,
    required this.password,
    required this.confirmed_password,
  });
  @override
  List<Object> get props => [];
}
