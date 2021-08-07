part of 'clients_bloc.dart';

@immutable
abstract class ClientsState {}

class ClientsInitial extends ClientsState {}

class ClientFetchingState extends ClientsState {}

class LoadMoreClients extends ClientsState {}

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
  });
}

class ClientFetchingFailedState extends ClientsState {
  late final String message;
  ClientFetchingFailedState({required this.message});
}

class ClientCreatingState extends ClientsState{}

class ClientCreateSuccesstate extends ClientsState{}

class ClientCreateFailedState extends ClientsState {
  late final String message;
  ClientCreateFailedState({required this.message});
}
