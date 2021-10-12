part of 'address_id_bloc.dart';

@immutable
abstract class AddressIdEvent {}

class FeatchAddressIdEvent extends AddressIdEvent {
  final int id;

  FeatchAddressIdEvent(this.id);
}
