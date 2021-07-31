import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/login_info.dart';
import '../../../repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginEventToState(event.user);
    }
  }

  Stream<AuthState> _mapLoginEventToState(LoginInfo user) async* {
    yield LoggingState();
    LoggedUserInfo u;
    try {
      u = await userRepository.login(user);
      // await util.storeUserInformation(u);
      yield LoginSuccessState(user: u);
    } on HttpException catch (e) {
      yield LoginFailedState(message: e.message);
    } catch (e) {
      yield LoginFailedState(message: 'Login Failed');
    }
  }
}
