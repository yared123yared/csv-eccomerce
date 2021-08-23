import 'dart:async';

import 'package:app/models/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_client_event.dart';
part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  AddClientBloc() : super(AddClientInitial());

  @override
  Stream<AddClientState> mapEventToState(
    AddClientEvent event,
  ) async* {
    if (event is ClientDisplayEvent) {
      // client display event
      yield StateChanged(state: true, client: event.client);
    } else if (event is ClientSearchEvent) {
      // client search event
      yield StateChanged(state: false, client: null);
    }
  }
}
