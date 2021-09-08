import 'package:app/Blocs/orderDrawer/AllOrder/cubit/allorders_cubit.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/cubit/allorders_state.dart';
import 'package:app/Widget/Orders/allOrders/data_container.dart';
import 'package:app/Widget/Orders/allOrders/search_container.dart';
import 'package:app/Widget/dashboard/daily_debt.dart';
import 'package:app/constants/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../drawer.dart';

class AllOrdersScreen extends StatefulWidget {
  static const routeName = "/allOrdersScreen";

  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


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
      SyncDataToServerEvent syncClientEvent = SyncDataToServerEvent();
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
      print("all--order--screen--53");
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
      // print("connected");
      SyncDataToServerEvent syncClientEvent = SyncDataToServerEvent();
      BlocProvider.of<ClientsBloc>(context, listen: false).add(syncClientEvent);
    }

    // return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;

      if (_connectionStatus != ConnectivityResult.none) {
        print("connected");
        SyncDataToServerEvent syncClientEvent = SyncDataToServerEvent();
        BlocProvider.of<ClientsBloc>(context).add(syncClientEvent);
      }
    });
  }


  @override
  void initState() {
    bloc = BlocProvider.of<AllorderrBloc>(context);
    bloc.add(FeatcAllorderrEvent());

    super.initState();

  @override
  void dispose() {
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
        title: const Text(
          "All Orders",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
      backgroundColor: lightColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            child: SearchContinerAllOrder(),
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<AllorderrBloc, AllorderrState>(
            builder: (context, state) {
              if (state is AllOrdersSuccessState) {
                return Text(
                  "Showing 1 to 5 of ${state.allorderdata.length} entries",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                );
              } else if (state is SearchDataSccessState) {
                return Text(
                  "Showing 1 to 5 of ${state.searchallorderdata.length} entries",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                );
              }
              return Text(
                "Showing 1 to 5 of 5 entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: DataContainerAllOrders(),
          ),
        ],
      ),
    );
  }
}
