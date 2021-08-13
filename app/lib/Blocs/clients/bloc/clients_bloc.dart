import 'dart:async';
import 'package:app/models/client.dart';
import 'package:app/models/search.dart';
import 'package:app/repository/clients_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final ClientsRepository clientsRepository;
  Map<int, ClientData> clients = {};

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
      yield* _mapFetchClientsToState(event.page, dataX);
    } else if (event is CreateClientEvent) {
      yield* _mapCreateClientToState(event.data);
    } else if (event is UpdateClientEvent) {
      yield* _mapUpdateClientToState(event.data);
    } else if (event is DeleteClientEvent) {
      yield* _mapDeleteClientToState(event.id);
    } else if (event is SearchClientsEvent) {
      SearchData dataX = SearchData(
        draw: 0,
        length: 5,
        search: event.key,
        column: 0,
        field: "first_name",
        relationship: false,
        relationshipField: "",
        dir: "asc",
      );
      yield* _mapFetchClientsToState(1, dataX);
    }
  }

  Stream<ClientsState> _mapFetchClientsToState(
    int page,
    SearchData dataX,
  ) async* {
    yield ClientFetchingState();
    try {
      // ClientData? data = clients[page];
      // if (data == null) {
      final reqData = await clientsRepository.getClients(dataX, page);
      // clients[page] = ClientData(
      //   clients: reqData.clients.client,
      //   end: reqData.clients.to,
      //   start: reqData.clients.from,
      //   total: reqData.clients.total,
      // );
      // print(reqData.toJson().toString());
      yield ClientFetchingSuccessState(
        clients: reqData.clients.client,
        end: reqData.clients.to,
        start: reqData.clients.from,
        total: reqData.clients.total,
      );
      return;
      // }
      // yield ClientFetchingSuccessState(
      //   clients: data.clients,
      //   end: data.end,
      //   start: data.start,
      //   total: data.total,
      // );
      // return;
    } catch (e) {
      yield ClientFetchingFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapCreateClientToState(CreateEditData data) async* {
    yield ClientCreatingState();
    try {
      await clientsRepository.createClient(data);
      yield ClientCreateSuccesstate();
      return;
    } catch (e) {
      yield ClientCreateFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapUpdateClientToState(CreateEditData data) async* {
    yield ClientUpdatingState();
    try {
      await clientsRepository.updateClient(data);
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
      final reqData = await clientsRepository.getClients(dataX, 1);
      clients[1] = ClientData(
        clients: reqData.clients.client,
        end: reqData.clients.to,
        start: reqData.clients.from,
        total: reqData.clients.total,
      );

      yield ClientFetchingSuccessState(
        clients: reqData.clients.client,
        end: reqData.clients.to,
        start: reqData.clients.from,
        total: reqData.clients.total,
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
