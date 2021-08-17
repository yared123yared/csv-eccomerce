part of 'add_client_bloc.dart';

abstract class AddClientEvent {
  const AddClientEvent();
}

class ClientDisplayEvent extends AddClientEvent {}

class ClientSearchEvent extends AddClientEvent {}
