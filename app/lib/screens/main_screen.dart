import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/cart.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/category_screen.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/drawer.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  // final LoggedUserInfo user;
  // MainScreen({required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late CartBloc cartBloc;
  int check = 1;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('CSV'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,

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
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
      // drawer:
      body: this.check == 0
          ? HomeScreen()
          : this.check == 1
              ? CategoryScreen()
              : this.check == 2
                  ? CartScreen()
                      : SettingScreen(),
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

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}
