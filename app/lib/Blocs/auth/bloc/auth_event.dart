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
