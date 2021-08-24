part of 'clients_bloc.dart';

@immutable
abstract class ClientsEvent {}

class FetchClientsEvent extends ClientsEvent {
  final bool loadMore;
  FetchClientsEvent({
    required this.loadMore,
  });
  // @override
  // List<Object> get props => [page];
}

class SearchClientsEvent extends ClientsEvent {
  final String key;
  SearchClientsEvent({
    required this.key,
  });
  @override
  List<Object> get props => [key];
}

class CreateClientEvent extends ClientsEvent {
  late final CreateEditData data;
  CreateClientEvent({required this.data});
  @override
  List<Object> get props => [this.data];
}

class UpdateClientEvent extends ClientsEvent {
  late final CreateEditData data;
  UpdateClientEvent({required this.data});
  @override
  List<Object> get props => [this.data];
}

class DeleteClientEvent extends ClientsEvent {
  late final String id;
  DeleteClientEvent({required this.id});
  @override
  List<Object> get props => [id];
}
class SyncClientEvent extends ClientsEvent {
  SyncClientEvent();
  @override
  List<Object> get props => [];
}
