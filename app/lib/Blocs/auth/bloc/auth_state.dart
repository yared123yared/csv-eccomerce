part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoggingState extends AuthState {}

class LoginSuccessState extends AuthState {
  late final LoggedUserInfo user;
  LoginSuccessState({required this.user});
}

class LoginFailedState extends AuthState {
  late final String message;
  LoginFailedState({required this.message});
}
