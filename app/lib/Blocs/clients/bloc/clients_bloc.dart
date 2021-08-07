import 'dart:async';
import 'package:app/models/client.dart';
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
      yield* _mapFetchClientsToState(event.page);
    } else if (event is CreateClientEvent) {
      yield* _mapCreateClientToState(event.data);
    }
  }

  Stream<ClientsState> _mapFetchClientsToState(
    int page,
  ) async* {
    try {
      ClientData? data = clients[page];
      if (data == null) {
        final reqData = await clientsRepository.getClients(page);
        clients[page] = ClientData(
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
      }
      yield ClientFetchingSuccessState(
        clients: data.clients,
        end: data.end,
        start: data.start,
        total: data.total,
      );
    } catch (e) {
      yield ClientFetchingFailedState(message: e.toString());
    }
  }

  Stream<ClientsState> _mapCreateClientToState(CreateClientData data) async* {
    yield ClientCreatingState();
    try {
      await clientsRepository.createClient(data);
      ClientCreateSuccesstate();
    } catch (e) {
      yield ClientCreateFailedState(message: e.toString());
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
