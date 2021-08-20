part of 'add_client_bloc.dart';

abstract class AddClientEvent {
  const AddClientEvent();
}

class ClientDisplayEvent extends AddClientEvent {
  final Client client;
  ClientDisplayEvent({required this.client});
}

class ClientSearchEvent extends AddClientEvent {}
