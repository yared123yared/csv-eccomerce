import 'dart:async';

import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/clients_list/client.dart';
import 'package:app/Widget/clients/clients_list/searchBar.dart';
import 'package:app/models/client.dart';
import 'package:app/screens/client_detail_screen.dart';
import 'package:app/screens/client_edit_screen.dart';
import 'package:app/screens/drawer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ClientsScreen extends StatefulWidget {
  static const routeName = 'client_screen';
  // final LoggedUserInfo user;
  // final GlobalKey<ScaffoldState> scaffoldKey;
  ClientsScreen(
//  {
//     required this.scaffoldKey,
//   }
      );
  // const ClientsScreen({
  //   required this.user,
  // });

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

// final _scaffoldKey = GlobalKey<ScaffoldKey>();

class _ClientsScreenState extends State<ClientsScreen> {
  List<Client>? clients = [];
  int start = 0;
  int end = 0;
  int total = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

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

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("-----tttt---");
    if (_connectionStatus != ConnectivityResult.none) {
      print("did change dipendency connected");
      SyncClientEvent syncClientEvent = SyncClientEvent();
      BlocProvider.of<ClientsBloc>(context).add(syncClientEvent);
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("main--screen--53");
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
    if (result != ConnectivityResult.none) {
      print("connected");
      SyncClientEvent syncClientEvent = SyncClientEvent();
      BlocProvider.of<ClientsBloc>(context, listen: false).add(syncClientEvent);
    }

    // return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;

      if (_connectionStatus != ConnectivityResult.none) {
        print("connected");
        SyncClientEvent syncClientEvent = SyncClientEvent();
        BlocProvider.of<ClientsBloc>(context).add(syncClientEvent);
      }
    });
  }

  void editClient() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Clients',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            height: 5.0,
            width: 5.0,
            child: ImageIcon(
              AssetImage('assets/images/left-align.png'),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              ClientEditScreen.routeName,
              // arguments: state.user,
            ),
            icon: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      //         height: MediaQuery.of(context).size.height -
      // AppBar().preferredSize.height -
      // 90,

      body: Container(
        color: Color(0xFFf2f6f9),
        child: Column(
          children: [
            SearchBar(),
            SizedBox(
              height: 8.0,
            ),
            BlocConsumer<ClientsBloc, ClientsState>(
              // buildWhen: (previous, current) => current.check != false,
              listener: (context, state) {
                if (state is ClientDeleteSuccesstate) {
                  FetchClientsEvent refechEvent =
                      new FetchClientsEvent(loadMore: false);
                  BlocProvider.of<ClientsBloc>(context, listen: false)
                      .add(refechEvent);
                } else if (state is ClientDeleteFailedState) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.NO_HEADER,
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
                  if (state.clients != null) {
                    total = state.clients!.length;
                    if (state.clients!.length == 0) {
                      start = 0;
                      end = 0;
                    }
                  }
                } else if (state is ClientFetchingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ClientFetchingFailedState) {
                  return Center(
                    child: Text('Client Fetch Failed'),
                  );
                }

                return Container(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).size.height * 0.12 -
                      4.9,
                  child: Column(
                    children: [
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
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ClientDetailScreen.routeName,
                                    arguments: clients![index],
                                  );
                                },
                                child: ClientCard(
                                  client: clients![index],
                                  deleteClient: () {},
                                  editClient: editClient,
                                ),
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
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
