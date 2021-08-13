part of 'clients_bloc.dart';

@immutable
abstract class ClientsState {
  final bool check;
  ClientsState({required this.check});
}

class ClientsInitial extends ClientsState {
  ClientsInitial() : super(check: true);
}

class ClientFetchingState extends ClientsState {
  ClientFetchingState() : super(check: true);
}

class LoadMoreClients extends ClientsState {
  LoadMoreClients() : super(check: true);
}

class ClientFetchingSuccessState extends ClientsState {
  late final List<Client>? clients;
  final int? start;
  final int? end;
  final int? total;
  ClientFetchingSuccessState({
    required this.clients,
    required this.start,
    required this.end,
    required this.total,
  }) : super(check: true);
}

class ClientFetchingFailedState extends ClientsState {
  late final String message;
  ClientFetchingFailedState({required this.message}) : super(check: true);
}

class ClientCreatingState extends ClientsState {
  ClientCreatingState() : super(check: true);
}

class ClientCreateSuccesstate extends ClientsState {
  ClientCreateSuccesstate() : super(check: true);
}

class ClientCreateFailedState extends ClientsState {
  late final String message;
  ClientCreateFailedState({required this.message}) : super(check: true);
}

class ClientDeletingState extends ClientsState {
  ClientDeletingState() : super(check: true);
}

class ClientDeleteSuccesstate extends ClientsState {
  late final String id;
  ClientDeleteSuccesstate({required this.id}) : super(check: true);
}

class ClientDeleteFailedState extends ClientsState {
  late final String message;
  ClientDeleteFailedState({required this.message}) : super(check: false);
}


class ClientUpdatingState extends ClientsState {
  ClientUpdatingState() : super(check: true);
}

class ClientUpdateSuccesstate extends ClientsState {
  ClientUpdateSuccesstate() : super(check: true);
}

class ClientUpdateFailedState extends ClientsState {
  late final String message;
  ClientUpdateFailedState({required this.message}) : super(check: true);
}
