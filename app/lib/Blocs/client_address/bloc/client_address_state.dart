part of 'client_address_bloc.dart';

abstract class ClientAddressState {}

class ClientAddressInitial extends ClientAddressState {}

class ClientAddressLoadedState extends ClientAddressState {
  final List<ClientsAddressIdModel> clientAddress;

  ClientAddressLoadedState(this.clientAddress);
}
