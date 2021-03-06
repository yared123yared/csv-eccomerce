import 'dart:async';

import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/categories/bloc/categories_bloc.dart';
import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Blocs/dashBoard/numbers/bloc/number_dashboard_bloc.dart';
import 'package:app/Blocs/dashBoard/recentOrder/bloc/recent_order_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/cart.dart';
import 'package:app/constants/constants.dart';
import 'package:app/db/db.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/screens/cart_screens/cart_screen.dart';
import 'package:app/screens/category_screen.dart';
// import 'package:app/screens/client_profile.dart';
import 'package:app/screens/client_profile_copy.dart';
import 'package:app/screens/drawer.dart';
import 'package:app/screens/dashBorad_screen.dart';
import 'package:app/screens/setting_screen.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  final int checkValue;
  MainScreen({required this.checkValue});
  // final LoggedUserInfo user;
  // MainScreen({required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late ProductBloc productBloc;
  late CartBloc cartBloc;
  late CategoriesBloc categoriesBloc;
  late ClientsBloc clientsBloc;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    getLanguagePref();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    check = widget.checkValue;
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
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
      SyncDataToServerEvent syncClientEvent = SyncDataToServerEvent();
      BlocProvider.of<ClientsBloc>(context, listen: false).add(syncClientEvent);
    }

    // return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  List<String> flagsChange = [
    "????????",
    "????????",
  ];
  String selectedLang = "????????";

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // late CartBloc cartBloc;
  int check = 1;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    clientsBloc = BlocProvider.of<ClientsBloc>(context);
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: this.check == 0
            ? Text('CSV')
            : this.check == 1
                ? Text('CSV')
                : this.check == 2
                    ? Text('CSV')
                    : Text(cubit.tClientProfile()),
        // title: Text(
        //   "CSV",
        //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        // ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 40),
            child: DropdownButton<String>(
              value: selectedLang,
              onChanged: (String? langValue) async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("language", langValue!);
                cubit.setLanguage(langValue);

                setState(() {
                  selectedLang = langValue;
                });
              },
              iconEnabledColor: primaryColor,
              style: TextStyle(fontSize: 18),
              underline: SizedBox(),
              items: flagsChange.map((lang) {
                return DropdownMenuItem(
                  child: Text(lang),
                  value: lang,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                print("REFRESH ICON BUTTON HAVE BEEN CLIEKCED");
                //  CsvDatabse.instance.DeleteDatabase();
                // await  CsvDatabse.instance.clearProductsAndCategories();
                // await CsvDatabse.instance.deletePhot();
                // await CsvDatabse.instance.deletePiv();
                // await CsvDatabse.instance.deleteAttr();
                // await CsvDatabse.instance.deletePro();
                // await CsvDatabse.instance.deleteProCat();
                bool connected =
                    await ConnectionChecker.CheckInternetConnection();
                if (connected) {
                  await CsvDatabse.instance.clearData();
                }
                productBloc.add(FetchProduct());
                cartBloc.add(InitializeCart());
                categoriesBloc.add(FetchCategories());
                clientsBloc.add(ClientInitialize());
                clientsBloc.add(FetchClientsEvent(loadMore: true));
              },
              icon: Icon(Icons.refresh),
            ),
          ),
        ],
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
      ),

      drawer: AppDrawer(
        onPressed: this.changeToDashbord,
      ),
      drawerEnableOpenDragGesture: true,
      // drawer:
      body: this.check == 0
          ? DashBoardScreen()
          : this.check == 1
              ? CategoryScreen()
              : this.check == 2
                  ? CartScreen()
                  : ClientProfileCopy(),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Image.asset(
                  'assets/icons/home.png',
                  color:
                      check == 0 ? Theme.of(context).primaryColor : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    check = 0;
                  });
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Image.asset(
                  'assets/icons/categories.png',
                  color:
                      check == 1 ? Theme.of(context).primaryColor : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    check = 1;
                  });
                },
              ),
            ),
            // Expanded(child: new Text('')),
            Expanded(
              child:
                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return IconButton(
                  icon: Cart(
                    value: state.counter,
                    check: check,
                  ),
                  onPressed: () {
                    setState(() {
                      check = 2;
                    });
                  },
                );
              }),
            ),
            Expanded(
              child: IconButton(
                icon: Image.asset(
                  'assets/icons/um2.png',
                  color:
                      check == 3 ? Theme.of(context).primaryColor : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    check = 3;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLanguagePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      String? lang = pref.getString("language");
      if (lang != null) {
        selectedLang = lang;
      }
    });
  }

  void changeToDashbord() {
    setState(() {
      check = 0;
    });
  }
}
