import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/clients_list/client.dart';
import 'package:app/Widget/clients/clients_list/searchBar.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/client.dart';
import 'package:app/models/route_args.dart';
import 'package:app/screens/cart_screens/add_client.dart';
import 'package:app/screens/client_edit_screen.dart';
import 'package:app/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'client-item.dart';

class ClientsDisplay extends StatefulWidget {
  static const routeName = 'client_screen';

  // final LoggedUserInfo user;
  // final GlobalKey<ScaffoldState> scaffoldKey;

  // const ClientsScreen({
  //   required this.user,
  // });

  @override
  _ClientsDisplayState createState() => _ClientsDisplayState();
}

// final _scaffoldKey = GlobalKey<ScaffoldKey>();

class _ClientsDisplayState extends State<ClientsDisplay> {
  List<Client>? clients = [];
  int start = 0;
  int end = 0;
  int total = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value
          .map((item) => item.index)
          .toList();
      if (indices.length > 0) {
        setState(() {
          if (clients != null) {
            if (clients!.length > 0) {
              start = indices[0] + 1;
              end = indices.length;
            }
          }
        });
      }
    });
  }

  void editClient() {}
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Container(
      color: Color(0xFFf2f6f9),
      child: BlocConsumer<ClientsBloc, ClientsState>(
        // buildWhen: (previous, current) => current.check != false,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ClientFetchingSuccessState) {
            // state.products.map((product) {});
            clients = state.clients;
            if (state.clients != null) {
              total = state.clients!.length;
              if (state.clients!.length == 0) {
                start = 0;
                end = 0;
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      print("Add new client button have been cliecked");
                      Navigator.popAndPushNamed(
                        context,
                        ClientEditScreen.routeName,
                        arguments: ClientEditArgs(
                          from: "checkout",
                        ),
                      );
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            cubit.tAddNewClient(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                );
              }
            } else {}
          } else if (state is ClientFetchingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ClientFetchingFailedState) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  print("Add new client button have been cliecked");
                  Navigator.popAndPushNamed(
                    context,
                    ClientEditScreen.routeName,
                    arguments: ClientEditArgs(
                      from: "checkout",
                    ),
                  );
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        cubit.tAddNewClient(),
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            );
          }

          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () {
                      FetchClientsEvent refechEvent =
                          new FetchClientsEvent(loadMore: true);
                      BlocProvider.of<ClientsBloc>(context, listen: false)
                          .add(refechEvent);
                    },
                    scrollOffset: 70,
                    child: ScrollablePositionedList.builder(
                      itemCount: clients!.length,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemBuilder: (BuildContext ctx, index) {
                        return ClientItem(
                          client: clients![index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
