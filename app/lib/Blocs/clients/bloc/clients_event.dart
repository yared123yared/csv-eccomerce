part of 'clients_bloc.dart';

@immutable
abstract class ClientsEvent {}

class FetchClientsEvent extends ClientsEvent {
  final int page;
  FetchClientsEvent({
    required this.page,
  });
  @override
  List<Object> get props => [page];
}

class CreateClientEvent extends ClientsEvent {
  late final CreateClientData data;
  CreateClientEvent({required this.data});
  @override
  List<Object> get props => [data];
}
