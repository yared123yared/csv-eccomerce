import 'package:app/data_provider/clients_data_provider.dart';
import 'package:app/models/client.dart';
import 'package:app/models/search.dart';

class ClientsRepository {
  final ClientsDataProvider clientsDataProvider;
  ClientsRepository({required this.clientsDataProvider});

  Future<ClientAutogenerated> getClients(SearchData dataX, int page) async {
    ClientAutogenerated data = await clientsDataProvider.getClients(dataX,page);
    return data;
  }

  Future<SearchClientData?> searchClients(String key) async {
    SearchClientData? data =
        await clientsDataProvider.searchClients(key);
    return data;
  }

  Future<Client?> createClient(CreateEditData data) async {
    return await clientsDataProvider.createClient(data);
  }

  Future<void> deleteClient(String id) async {
    return await clientsDataProvider.deleteClient(id);
  }

  Future<Client?> updateClient(CreateEditData data) async {
    return await clientsDataProvider.updateClient(data);
  }
}
