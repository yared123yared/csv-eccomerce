import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/clients_list/searchBar.dart';
import 'package:app/Widget/clients/clients_list/client.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/client.dart';
import 'package:app/screens/client_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ClientsScreen extends StatefulWidget {
  static const routeName = 'client_screen';
  // final LoggedUserInfo user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  ClientsScreen({
    required this.scaffoldKey,
  });
  // const ClientsScreen({
  //   required this.user,
  // });

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

// final _scaffoldKey = GlobalKey<ScaffoldKey>();

class _ClientsScreenState extends State<ClientsScreen> {
  List<Client>? clients = [];
  int? start = 0;
  int? end = 0;
  int? total = 0;

  void editClient() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFf2f6f9),
      child: BlocConsumer<ClientsBloc, ClientsState>(
        buildWhen: (previous, current) => current.check != false,
        listener: (context, state) {
          if (state is ClientDeleteSuccesstate) {
            FetchClientsEvent refechEvent = new FetchClientsEvent(page: 0);
            BlocProvider.of<ClientsBloc>(context, listen: false)
                .add(refechEvent);
          } else if (state is ClientDeleteFailedState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Delete Error',
              desc: state.message,
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
        },
        builder: (context, state) {
          if (state is ClientFetchingSuccessState) {
            // state.products.map((product) {});
            clients = state.clients;
            start = state.start;
            end = state.end;
            total = state.end;
          } else if (state is ClientFetchingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ClientFetchingFailedState) {
            return Center(
              child: Text('Cient Fetch Failed'),
            );
          }
          return Column(
            children: [
              // SearchBar(),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'showing ${start} to ${end} of ${total} entries',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: LazyLoadScrollView(
                  onEndOfPage: () {},
                  child: ListView.builder(
                    itemCount: clients!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      // print(clients![index].id);
                      return ClientCard(
                        client: clients![index],
                        deleteClient: () {},
                        editClient: editClient,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
