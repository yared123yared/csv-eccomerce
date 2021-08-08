import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/cart.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/login_info.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/category_screen.dart';
import 'package:app/screens/client_new_screen.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/drawer.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_screen.dart';

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
  int _selectedIndex = 0;
  int check = 1;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: this.check == 5
              ? Text(
                  'Client Profile',
                )
              : this.check == 7
                  ? Text(
                      'Clients',
                    )
                  : this.check == 8
                      ? Text(
                          'Create Client',
                        )
                      : Text('CSV'),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Container(
              height: 5.0,
              width: 5.0,
              child: ImageIcon(
                AssetImage('assets/images/left-align.png'),
              ),
            ),
          ),
          actions: this.check == 7
              ? [
                  IconButton(
                    onPressed: () => setState(() {
                      check = 8;
                    }),
                    icon: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                    ),
                  )
                ]
              : [],
        ),
        drawerEnableOpenDragGesture: true,
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Theme.of(context)
                  .primaryColor, //This will change the drawer background to blue.
              //other styles
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Drawer(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if ((state is LoginSuccessState)) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DrawerHeader(
                                    padding: EdgeInsets.all(16.0),
                                    child: InkWell(
                                      // onTap: () => Navigator.of(context).pushNamed(
                                      //   ClientProfile.routeName,
                                      //   arguments: state.user,
                                      // ),
                                      onTap: () {
                                        setState(() {
                                          this.check = 5;
                                          print(this.check);
                                        });
                                      },

                                      child: Container(
                                        child: Column(
                                          children: [
                                            // state.user.user!.photo == null
                                            // ?
                                            CircleAvatar(
                                              radius: 45.0,
                                              backgroundImage: AssetImage(
                                                  'assets/images/16.jpg'),
                                            ),
                                            //: CircleAvatar(
                                            //   radius: 50.0,
                                            //  backgroundImage: NetworkImage(
                                            //  state.user.user!.photo!),
                                            //),
                                            Text(
                                              'Crm Admistratora',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 25),
                                    // decoration: BoxDecoration(
                                    //   color: Colors.white,
                                    //   borderRadius: BorderRadius.only(
                                    //     topRight: Radius.circular(30),
                                    //     bottomRight: Radius.circular(30),
                                    //   ),
                                    // ),
                                    child: ListTile(
                                      // onTap: () {
                                      //   Navigator.pushNamed(
                                      //       context, MainScreen.routeName);
                                      // },
                                      onTap: () {
                                        setState(() {
                                          this.check;
                                        });
                                      },
                                      leading: Icon(
                                        Icons.home,
                                        size: 40.0,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        'Dashboard',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DrawerListTile(
                                    'Categories',
                                    0,
                                    Icons.list_alt,
                                    () => {},
                                  ),
                                  DrawerListTile(
                                      'Products', 4, Icons.shop, () => {}),
                                  DrawerListTile(
                                    'Clients',
                                    0,
                                    Icons.person,
                                    () => setState(() {
                                     this.check = 7;
                                    }),
                                  ),

                                  DrawerListTile(
                                    'Product Catalog',
                                    0,
                                    Icons.production_quantity_limits_sharp,
                                    () => Navigator.of(context)
                                        .pushNamed(ClientsScreen.routeName),
                                  ),
                                  DrawerExpansionTile(
                                    'Orders',
                                    [
                                      ExapandedListItem('Sales Report', () {}),
                                      ExapandedListItem(
                                          'Collection Report', () {}),
                                      ExapandedListItem('Order by debt', () {}),
                                      ExapandedListItem(
                                          'Customer by debt', () {}),
                                    ],
                                    4,
                                    Icons.shopping_bag,
                                  ),
                                  DrawerExpansionTile(
                                    'Client Management',
                                    [
                                      ExapandedListItem('Clients', () {}),
                                      ExapandedListItem('Invoices', () {}),
                                      ExapandedListItem('Add Money', () {}),
                                    ],
                                    4,
                                    Icons.handyman,
                                  ), // DrawerHeader(child: )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Login.routeName);
                            },
                            child: Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width * 4 / 5,
                              child: ListTile(
                                tileColor: primaryDark,
                                leading: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                title: Text(
                                  'Sign out',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (state is AutoLoginSuccessState) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DrawerHeader(
                                    padding: EdgeInsets.all(16.0),
                                    child: InkWell(
                                      onTap: () =>
                                          Navigator.of(context).pushNamed(
                                        ClientProfile.routeName,
                                        arguments: state.user,
                                      ),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            state.user.user!.photo == null
                                                ? CircleAvatar(
                                                    radius: 50.0,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/16.jpg'),
                                                  )
                                                : CircleAvatar(
                                                    radius: 50.0,
                                                    backgroundImage:
                                                        NetworkImage(state
                                                            .user.user!.photo!),
                                                  ),
                                            Text(
                                              'Crm Admistratora',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.home,
                                        size: 40.0,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        'Dashboard',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DrawerListTile(
                                    'Categories',
                                    0,
                                    Icons.list_alt,
                                    () => {},
                                  ),
                                  DrawerListTile(
                                      'Products', 4, Icons.shop, () => {}),
                                  DrawerListTile(
                                    'Clients',
                                    4,
                                    Icons.person,
                                    () => Navigator.of(context).pushNamed(
                                      ClientsScreen.routeName,
                                      arguments: state.user,
                                    ),
                                  ),

                                  DrawerListTile(
                                    'Product Catalog',
                                    4,
                                    Icons.production_quantity_limits_sharp,
                                    () => Navigator.of(context)
                                        .pushNamed(ClientsScreen.routeName),
                                  ),
                                  DrawerExpansionTile(
                                    'Orders',
                                    [
                                      ExapandedListItem('Sales Report', () {}),
                                      ExapandedListItem(
                                          'Collection Report', () {}),
                                      ExapandedListItem('Order by debt', () {}),
                                      ExapandedListItem(
                                          'Customer by debt', () {}),
                                    ],
                                    4,
                                    Icons.shopping_bag,
                                  ),
                                  DrawerExpansionTile(
                                    'Client Management',
                                    [
                                      ExapandedListItem('Clients', () {}),
                                      ExapandedListItem('Invoices', () {}),
                                      ExapandedListItem('Add Money', () {}),
                                    ],
                                    4,
                                    Icons.handyman,
                                  ), // DrawerHeader(child: )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * 4 / 5,
                            child: ListTile(
                              tileColor: primaryDark,
                              leading: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              title: Text(
                                'Sign out',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text('Login');
                  },
                ),
              ),
            )),
        body: this.check == 0
            ? HomeScreen()
            : this.check == 1
                ? CategoryScreen()
                : this.check == 2
                    ? CartScreen()
                    : this.check == 5
                        ? ClientProfile()
                        : this.check == 7
                            ? ClientsScreen()
                            : this.check == 8
                                ? NewClientScreen()
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
        )));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ListTile DrawerListTile(
    String title,
    int count,
    IconData data,
    Function onTap,
  ) {
    Text text = Text(
      // '',
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
    return ListTile(
      leading: Icon(
        data,
        size: 35.0,
        color: Colors.white,
      ),
      onTap: () => onTap(),
      title: count > 0
          ? Row(
              children: [
                text,
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            )
          : text,
    );
  }

  ExpansionTile DrawerExpansionTile(
    String title,
    List<Widget> items,
    int count,
    IconData data,
  ) {
    Text text = Text(
      // 'Master',
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      iconColor: Colors.white,
      // collapsedBackgroundColor: Colors.white,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      leading: Icon(
        data,
        size: 30.0,
        color: Colors.white,
      ),
      title: (count > 0)
          ? Row(
              children: [
                text,
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            )
          : text,
      // children: [
      //   ExapandedListItem('Countries', () {}),
      //   ExapandedListItem('States', () {}),
      // ],
      children: items,
    );
  }

  GestureDetector ExapandedListItem(
    String title,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.only(left: 70.0),
        margin: EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
