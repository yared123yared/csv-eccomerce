import 'dart:async';
import 'dart:convert';
import 'package:app/db/db.dart';
import 'package:app/models/request/request.dart';
import 'package:app/repository/orders_repository.dart';
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
  final OrderRepository orderRepository;

  List<Client> clients = [];
  int page = 1;
  int endOfPage = 1;
  bool syncing = false;
  bool isFirstFetch = false;
  ClientsBloc({
    required this.clientsRepository,
    required this.orderRepository,
  }) : super(ClientsInitial());

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
    } else if (event is SyncDataToServerEvent) {
      syncLocalDataToServer();
    }
  }

  Stream<ClientsState> _mapFetchClientsToState(
    SearchData dataX,
    bool loadMore,
  ) async* {
    yield ClientFetchingState();
    bool connected = await ConnectionChecker.CheckInternetConnection();
    if (!connected) {
      List<CreateEditData>? clts = await CsvDatabse.instance.readClients();
      if (clts == null) {
        yield ClientFetchingSuccessState(
          clients: this.clients,
        );
      } else {
        List<Client> cl2 = [];
        for (var c in clts) {
          cl2.add(
            Client(
              id: c.id == null ? 0 : int.parse(c.id as String),
              addresses: c.addresses,
              firstName: c.firstName,
              email: c.email,
              lastName: c.lastName,
              mobile: c.mobile,
              photo: Photo(id: 0, filePath: c.uploadedPhoto),
              debts: c.debt,
              documents: c.documents,
            ),
          );
        }
        yield ClientFetchingSuccessState(
          clients: cl2,
        );

        return;
      }
    }
    if (isFirstFetch) {
      if (!syncing) {
        await syncLocalDataToServer();
      }
    }
    int prevPage = page;
    try {
      if (page <= 0) {
        page = 1;
      }
      if (loadMore) {
        // if (endOfPage) {
        //   isFirstFetch = false;
        //   yield ClientFetchingSuccessState(
        //     clients: this.clients,
        //   );

        //   return;
        // }
        final reqData = await clientsRepository.getClients(dataX, page);
        print("page $page");
        print(reqData.clients.client!.length);
        if (reqData.clients.client != null) {
          for (var i = 0; i < reqData.clients.client!.length; i++) {
            bool isFound = false;
            for (var j = 0; j < this.clients.length; j++) {
              if (reqData.clients.client![i].id == this.clients[j].id) {
                isFound = true;
                break;
              }
            }
            if (!isFound) {
              await CsvDatabse.instance.create(
                CreateEditData(
                  id: reqData.clients.client![i].id.toString(),
                  type: '',
                  uploadedPhoto:
                      reqData.clients.client![i].photo?.filePath ?? "",
                  documents: reqData.clients.client![i].documents,
                  firstName: reqData.clients.client![i].firstName.toString(),
                  lastName: reqData.clients.client![i].lastName.toString(),
                  companyname:
                      reqData.clients.client![i].companyName.toString(),
                  mobile: reqData.clients.client![i].mobile.toString(),
                  email: reqData.clients.client![i].email.toString(),
                  debt: reqData.clients.client![i].debts,
                  addresses: reqData.clients.client![i].addresses == null
                      ? []
                      : (reqData.clients.client![i].addresses
                          as List<Addresses>),
                ),
              );
              this.clients.add(reqData.clients.client![i]);
            }
          }
          // if (reqData.clients.client!.length < 5) {
          //   endOfPage = true;
          // }
          // if(isFirstFetch){

          // }
          // page++;
          page = reqData.clients.lastPage as int;
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
      bool connected = await ConnectionChecker.CheckInternetConnection();
      print("-s--connected--${connected}");
      if (!connected) {
        List<CreateEditData>? clts =
            await CsvDatabse.instance.searchClients(key);
        if (clts == null) {
          yield ClientFetchingSuccessState(
            clients: this
                .clients
                .where((element) => (element.firstName == key ||
                    element.mobile == key ||
                    element.email == key ||
                    element.lastName == key))
                .toList(),
          );
          return;
        } else {
          List<Client> cl2 = [];
          for (var c in clts) {
            cl2.add(
              Client(
                id: c.id == null ? int.parse(c.id as String) : 0,
                addresses: c.addresses,
                firstName: c.firstName,
                email: c.email,
                lastName: c.lastName,
                mobile: c.mobile,
                photo: Photo(id: 0, filePath: c.uploadedPhoto),
                debts: c.debt,
                documents: c.documents,
              ),
            );
          }
          yield ClientFetchingSuccessState(
            clients: cl2,
          );
          return;
        }
      }
      List<Client>? cl = [];
      cl = await clientsRepository.searchClients(key);
      // if (reqData != null) {
      //   if (reqData.client != null) {
      //     cl.add(reqData.client as Client);
      //   }
      // }

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
      bool connected = await ConnectionChecker.CheckInternetConnection();
      if (!connected) {
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
              companyName: clientCreated.companyname,
              status: 1,
              debts: 0,
              id: int.parse(
                clientCreated.id.toString(),
              ));
          this.clients.add(clientX);
        }
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
      }
      try {
        Client? clientX = await clientsRepository.createClient(data);
        if (clientX != null) {
          this.clients.add(clientX);
        }
        int currentPageCount = this.clients.length ~/ 5;
        if (this.clients.length == 0) {
          page = 1;
        } else {
          if (currentPageCount > prevPageCount) {
            page++;
          }
        }
      } catch (e) {
        print("error occured while creating user");
        print(e);
        yield ClientCreateFailedState(message: e.toString());
        return;
      }
      syncLocalDataToServer();
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
      bool connected = await ConnectionChecker.CheckInternetConnection();
      if (!connected) {
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
              companyName: clientCreated.companyname,
              status: 1,
              // debts: data,
              id: int.parse(
                clientCreated.id.toString(),
              ),
            );
            // print("bloc--updated---on--db--2");
            // print("--data--id--${data.id}");
            // int index =
            // this.clients.indexWhere((element) => element.id == data.id);
            // print("--data--index${index}");
            // print("---legth--${this.clients.length}");
            // this.clients[index] = clientX;
            this.clients.removeWhere(
                (element) => element.id.toString() == data.id.toString());
            this.clients.add(clientX);
            // print("bloc--updated---on--db--3");
          }
          yield ClientUpdateSuccesstate();
          return;
        }
      } else {
        try {
          Client? clientX = await clientsRepository.updateClient(data);
          this.clients.removeWhere(
              (element) => element.id.toString() == data.id.toString());
          if (clientX != null) this.clients.add(clientX);
        } catch (e) {
          print("error occured while updating user");
          print(e);
          yield ClientCreateFailedState(message: e.toString());
          return;
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
      bool connected = await ConnectionChecker.CheckInternetConnection();
      if (!connected) {
        //   print("delete---not connected");
        int? insertedID =
            await CsvDatabse.instance.insertClientId(int.parse(id));
        if (insertedID != null) {
          await CsvDatabse.instance.deleteClient(insertedID);
        }
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
      } else {
        try {
          await clientsRepository.deleteClient(id);
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
        } catch (e) {
          print("error occured while deleting user");
          print(e);
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

  Future<void> syncLocalDataToServer() async {
    if (syncing) {
      return;
    }
    bool connected = await ConnectionChecker.CheckInternetConnection();
    if (connected) {
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
                print("creating---");
                Client? clientX = await clientsRepository.createClient(client);
                print("created on server");
                client.type = '';
                await CsvDatabse.instance.updateClientDataStatus(client);
              } else if (client.type == 'UPDATE') {
                print("updating---");
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
        // print("delete satrted");
        List<int> deletedIds =
            await CsvDatabse.instance.readAllDeletedClientIds();
        for (var id in deletedIds) {
          await clientsRepository.deleteClient(id.toString());
          CsvDatabse.instance.deleteClientID(id);
          int prevPageCount = this.clients.length ~/ 5;
          // print("prev -length--${this.clients.length}");
          this.clients.removeWhere((cl) => cl.id.toString() == id);
          // print("current -length--${this.clients.length}");

          int currentPageCount = this.clients.length ~/ 5;
          if (this.clients.length == 0) {
            page = 1;
          } else {
            if (currentPageCount < prevPageCount) {
              page--;
            }
          }
        }
        List<Request>? requests = await CsvDatabse.instance.readrequests();
        if (requests != null) {
          for (var req in requests) {
            try {
              await this.orderRepository.createOrder(req);
              int? id = await CsvDatabse.instance.deleteRequest(req.id!);
              print("deleted--request--order--${id}");
            } catch (e) {
              print("syncing--create--req--failed");
              print(e);
            }
          }
        }
        List<Request>? updateRequest =
            await CsvDatabse.instance.readUpdateOrderRequest();
        if (updateRequest != null) {
          for (var req in updateRequest) {
            try {
              await this.orderRepository.UpdateOrder(req);
              int? id =
                  await CsvDatabse.instance.deleteUpdateOrderRequest(req.id);
              print("deleted--update--order--${id}");
            } catch (e) {
              print("syncing--update--req--failed");
              print(e);
            }
            print("update request synced successfully");
          }
        }
      } catch (e) {
        syncing = false;
        print("bloc---error--sync-clients");
        print(e);
      }
      print("data synced successfully");
      syncing = false;
    }
  }
}

class ClientData {
  List<Client>? clients;
  int? start;
  int? end;
  int? total;
  ClientData({this.clients, this.start, this.end, this.total});
}
