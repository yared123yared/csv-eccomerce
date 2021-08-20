import 'dart:async';
import 'package:app/db/db.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:app/validation/validator.dart';
import 'package:meta/meta.dart';
import 'package:app/models/client.dart';
import 'package:app/models/search.dart';
import 'package:app/repository/clients_repository.dart';
import 'package:bloc/bloc.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final ClientsRepository clientsRepository;
  List<Client> clients = [];
  int page = 1;
  bool endOfPage = false;
  bool syncing = false;
  bool isFirstFetch = false;
  ClientsBloc({required this.clientsRepository}) : super(ClientsInitial());

  @override
  Stream<ClientsState> mapEventToState(
    ClientsEvent event,
  ) async* {
    if (event is FetchClientsEvent) {
      SearchData dataX = SearchData(
        draw: 0,
        length: 5,
        search: "",
        column: 0,
        field: "",
        relationship: false,
        relationshipField: "",
        dir: "asc",
      );
      yield* _mapFetchClientsToState(dataX, event.loadMore);
    } else if (event is CreateClientEvent) {
      print("create event triggered");
      yield* _mapCreateClientToState(event.data);
    } else if (event is UpdateClientEvent) {
      yield* _mapUpdateClientToState(event.data);
    } else if (event is DeleteClientEvent) {
      yield* _mapDeleteClientToState(event.id);
    } else if (event is SearchClientsEvent) {
      yield* _mapSearchClientsEventToState(
        event.key,
      );
    } else if (event is SyncClientEvent) {
      syncClients();
    }
  }

  Stream<ClientsState> _mapFetchClientsToState(
    SearchData dataX,
    bool loadMore,
  ) async* {
    yield ClientFetchingState();
    if (isFirstFetch) {
      if (!syncing) {
        await syncClients();
      }
    }
    int prevPage = page;
    try {
      if (page <= 0) {
        page = 1;
      }
      if (loadMore) {
        if (endOfPage) {
          isFirstFetch = false;
          yield ClientFetchingSuccessState(
            clients: this.clients,
          );

          return;
        }
        final reqData = await clientsRepository.getClients(dataX, page);

        if (reqData.clients.client != null) {
          for (var i = 0; i < reqData.clients.client!.length; i++) {
            await CsvDatabse.instance.create(
              CreateEditData(
                id: reqData.clients.client![i].id.toString(),
                type: '',
                uploadedPhoto: reqData.clients.client![i].firstName,
                documents: reqData.clients.client![i].documents,
                firstName: reqData.clients.client![i].firstName.toString(),
                lastName: reqData.clients.client![i].lastName.toString(),
                mobile: reqData.clients.client![i].mobile.toString(),
                email: reqData.clients.client![i].email.toString(),
                addresses: reqData.clients.client![i].addresses == null
                    ? []
                    : (reqData.clients.client![i].addresses as List<Addresses>),
              ),
            );
            this.clients.add(reqData.clients.client![i]);
          }
          if (reqData.clients.client!.length < 5) {
            endOfPage = true;
          }
          page++;
        }
      }
      isFirstFetch = false;
      yield ClientFetchingSuccessState(
        clients: this.clients,
      );
      return;
    } catch (e) {
      isFirstFetch = false;
      if (page > prevPage) {
        page--;
      }
      yield ClientFetchingFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapSearchClientsEventToState(
    String key,
  ) async* {
    yield ClientFetchingState();
    try {
      List<Client>? cl = [];
      final reqData = await clientsRepository.searchClients(key);
      if (reqData != null) {
        if (reqData.client != null) {
          cl.add(reqData.client as Client);
        }
      }

      yield ClientFetchingSuccessState(
        clients: cl,
      );
      return;
    } catch (e) {
      yield ClientFetchingFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapCreateClientToState(CreateEditData data) async* {
    yield ClientCreatingState();
    try {
      print("create called");
      int prevPageCount = this.clients.length ~/ 5;
      // bool connected = await ConnectionChecker.CheckInternetConnection();
      // print("-s--connected--${connected}");
      // if (!connected) {
      // print("create---not-connected-to-internet");
      data.type = 'CREATE';
      CreateEditData? clientCreated = await CsvDatabse.instance.create(data);
      if (clientCreated != null) {
        Client clientX = Client(
            isLocal: true,
            addresses: clientCreated.addresses,
            orders: [],
            firstName: clientCreated.firstName,
            lastName: clientCreated.lastName,
            mobile: clientCreated.mobile,
            email: clientCreated.email,
            status: 1,
            id: int.parse(
              clientCreated.id.toString(),
            ));
        this.clients.add(clientX);
      }
      // } else {
      //   print("create---connected-to-internet");
      //   Client? clientX = await clientsRepository.createClient(data);

      //   if (clientX != null) {
      //     this.clients.add(clientX);
      //   }
      // }

      int currentPageCount = this.clients.length ~/ 5;
      if (this.clients.length == 0) {
        page = 1;
      } else {
        if (currentPageCount > prevPageCount) {
          page++;
        }
      }
      yield ClientCreateSuccesstate();
      return;
    } catch (e) {
      print("bloc --create--client");
      print(e);
      yield ClientCreateFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapUpdateClientToState(CreateEditData data) async* {
    yield ClientUpdatingState();
    try {
      if (data.id != null) {
        data.type = 'UPDATE';
        CreateEditData? clientCreated =
            await CsvDatabse.instance.updateClient(data);
        print("bloc--updated---on--db");

        if (clientCreated != null) {
          Client clientX = Client(
            isLocal: true,
            addresses: clientCreated.addresses,
            orders: [],
            firstName: clientCreated.firstName,
            lastName: clientCreated.lastName,
            mobile: clientCreated.mobile,
            email: clientCreated.email,
            id: int.parse(
              clientCreated.id.toString(),
            ),
          );
          print("bloc--updated---on--db--2");
          print("--data--id--${data.id}");
          int index =
              this.clients.indexWhere((element) => element.id == data.id);
          print("--data--index${index}");
          print("---legth--${this.clients.length}");
          // this.clients[index] = clientX;
          this.clients.removeWhere((element) => element.id.toString() == data.id.toString());
          this.clients.add(clientX);
          print("bloc--updated---on--db--3");
        }
        yield ClientUpdateSuccesstate();
        return;
      }
    } catch (e) {
      print("bloc --update--client");
      print(e);
      yield ClientUpdateFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapDeleteClientToState(String id) async* {
    yield ClientDeletingState();
    try {
      // bool connected = await ConnectionChecker.CheckInternetConnection();
      // if (!connected) {
      //   print("delete---not connected");
      int? insertedID = await CsvDatabse.instance.insertClientId(int.parse(id));
      if (insertedID != null) {
        await CsvDatabse.instance.deleteClient(insertedID);
      }
      // } else {
      //   print("delete--- connected");
      //   await clientsRepository.deleteClient(id);
      // }
      int prevPageCount = clients.length ~/ 5;
      print("prev -length--${this.clients.length}");
      this.clients.removeWhere((cl) => cl.id.toString() == id);
      print("current -length--${this.clients.length}");

      int currentPageCount = clients.length ~/ 5;
      if (this.clients.length == 0) {
        page = 1;
      } else {
        if (currentPageCount < prevPageCount) {
          page--;
        }
      }
      yield ClientFetchingSuccessState(
        clients: this.clients,
      );
      return;
    } catch (e) {
      print("bloc --delete--client");
      print(e);
      yield ClientDeleteFailedState(message: e.toString());
    }
  }

  Future<void> syncClients() async {
    if (syncing) {
      return;
    }
    syncing = true;
    print("syncing started");
    try {
      print("0");
      List<CreateEditData>? clients = await CsvDatabse.instance.readClients();
      print("1");
      if (clients != null) {
        print("2");
        for (var client in clients) {
          print("3");

          try {
            if (client.type == 'CREATE') {
              Client? clientX = await clientsRepository.createClient(client);
              print("created on server");
              client.type = '';
              await CsvDatabse.instance.updateClientDataStatus(client);
            } else if (client.type == 'UPDATE') {
              Client? clientX = await clientsRepository.updateClient(client);
              print("updated on server");
              if (client.id != null) {
                client.type = '';
                await CsvDatabse.instance.updateClientDataStatus(client);
              }
            }
          } catch (e) {
            print("inner--bloc---error--sync-clients");
            print(e);
          }
        }
      }
      print("delete satrted");
      List<int> deletedIds =
          await CsvDatabse.instance.readAllDeletedClientIds();
      for (var id in deletedIds) {
        await clientsRepository.deleteClient(id.toString());
        CsvDatabse.instance.deleteClientID(id);
        int prevPageCount = this.clients.length ~/ 5;
        print("prev -length--${this.clients.length}");
        this.clients.removeWhere((cl) => cl.id.toString() == id);
        print("current -length--${this.clients.length}");

        int currentPageCount = this.clients.length ~/ 5;
        if (this.clients.length == 0) {
          page = 1;
        } else {
          if (currentPageCount < prevPageCount) {
            page--;
          }
        }
      }
    } catch (e) {
      syncing = false;
      print("bloc---error--sync-clients");
      print(e);
    }
    syncing = false;
  }
}

class ClientData {
  List<Client>? clients;
  int? start;
  int? end;
  int? total;
  ClientData({this.clients, this.start, this.end, this.total});
}
