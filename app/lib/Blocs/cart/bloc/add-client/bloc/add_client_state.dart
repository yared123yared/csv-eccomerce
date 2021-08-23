part of 'add_client_bloc.dart';

class AddClientState {
  final bool display_state;
  const AddClientState({required this.display_state});
}

class AddClientInitial extends AddClientState {
  AddClientInitial() : super(display_state: false);
}

class StateChanged extends AddClientState {
  final bool state;
  final Client? client;

  StateChanged({required this.state, this.client})
      : super(display_state: state);
}
