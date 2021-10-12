part of 'address_id_bloc.dart';

@immutable
abstract class AddressIdState {}

class AddressIdInitial extends AddressIdState {}

class AddressIdLoadedState extends AddressIdState {
  final List<AddressIdModel> addressesId;

  AddressIdLoadedState(this.addressesId);
}
