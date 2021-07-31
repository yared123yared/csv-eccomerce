part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  late final LoginInfo user;
  LoginEvent({required this.user});

  List<Object> get props => [];
}

class AutoLoginEvent extends AuthEvent{
  @override
  List<Object> get props => [];
}
