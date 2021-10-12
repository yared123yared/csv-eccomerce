import 'package:app/data_provider/client_address_data_provider/client_address_data_provider.dart';
import 'package:app/models/client_address_id/address_Id_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'address_id_event.dart';
part 'address_id_state.dart';

class AddressIdBloc extends Bloc<AddressIdEvent, AddressIdState> {
  final ClientAddressDataProvider clientAddressDataProvider;
  AddressIdBloc(this.clientAddressDataProvider) : super(AddressIdInitial()) {}

  @override
  Stream<AddressIdState> mapEventToState(
    AddressIdEvent event,
  ) async* {
    if (event is FeatchAddressIdEvent) {
      try {
        final addressId =
            await clientAddressDataProvider.getAddressId(event.id);
        yield AddressIdLoadedState(addressId);
      } catch (e) {}
    }
  }
}
