import 'package:app/data_provider/client_address_data_provider/client_address_data_provider.dart';
import 'package:app/models/client_address_id/clients_address_id.dart';
import 'package:bloc/bloc.dart';

part 'client_address_event.dart';
part 'client_address_state.dart';

class ClientAddressBloc extends Bloc<ClientAddressEvent, ClientAddressState> {
  final ClientAddressDataProvider clientAddressDataProvider;
  ClientAddressBloc(this.clientAddressDataProvider)
      : super(ClientAddressInitial()) {}

  @override
  Stream<ClientAddressState> mapEventToState(
    ClientAddressEvent event,
  ) async* {
    if (event is FeatchClientAddressEvent) {
      try {
        final clientAddress =
            await clientAddressDataProvider.getClientAddressId();
        yield ClientAddressLoadedState(clientAddress);
      } catch (e) {}
    }
  }
}
