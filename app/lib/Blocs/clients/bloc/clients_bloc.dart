import 'dart:async';
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
      yield* _mapCreateClientToState(event.data);
    } else if (event is UpdateClientEvent) {
      yield* _mapUpdateClientToState(event.data);
    } else if (event is DeleteClientEvent) {
      yield* _mapDeleteClientToState(event.id);
    } else if (event is SearchClientsEvent) {
      yield* _mapSearchClientsEventToState(
        event.key,
      );
    }
  }

  Stream<ClientsState> _mapFetchClientsToState(
    SearchData dataX,
    bool loadMore,
  ) async* {
    yield ClientFetchingState();
    int prevPage = page;
    try {
      if (page <= 0) {
        page = 1;
      }
      if (loadMore) {
        if (endOfPage) {
          yield ClientFetchingSuccessState(
            clients: this.clients,
          );
          return;
        }
        final reqData = await clientsRepository.getClients(dataX, page);

        if (reqData.clients.client != null) {
          for (var i = 0; i < reqData.clients.client!.length; i++) {
            this.clients.add(reqData.clients.client![i]);
          }
          if (reqData.clients.client!.length < 5) {
            endOfPage = true;
          }
          page++;
        }
      }
      yield ClientFetchingSuccessState(
        clients: this.clients,
      );
      return;
    } catch (e) {
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
      Client? clientX = await clientsRepository.createClient(data);

      int prevPageCount = this.clients.length ~/ 5;
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
      yield ClientCreateSuccesstate();
      return;
    } catch (e) {
      yield ClientCreateFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapUpdateClientToState(CreateEditData data) async* {
    yield ClientUpdatingState();
    try {
      Client? clientX = await clientsRepository.updateClient(data);
      if (clientX != null) {
        this.clients[this
            .clients
            .indexWhere((element) => element.id == clientX.id)] = clientX;
      }

      yield ClientUpdateSuccesstate();
      return;
    } catch (e) {
      yield ClientUpdateFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapDeleteClientToState(String id) async* {
    yield ClientDeletingState();
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
      yield ClientFetchingSuccessState(
        clients: this.clients,
      );

      return;
    } catch (e) {
      yield ClientDeleteFailedState(message: e.toString());
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
