import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/models/login_info.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

UserPreferences pref = UserPreferences();

class AppDrawer extends StatefulWidget {
  // final LoggedUserInfo user;

  // const AppDrawer({
  //   required this.user,
  // });
  AppDrawer();

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String? photo;
    // ImageProvider provider;
    // if (widget.user.user != null) {
    //   Navigator.of(context).pushReplacementNamed(Login.routeName);
    //   // if (widget.user.user!.photo != null) {
    //   //   photo = widget.user.user!.photo;
    //   // }
    // }
    // if (photo == null) {
    //   photo = 'assets/images/16.jpg';
    // }
    // provider=(photo==null)?

    return Container(
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
                              onTap: () => Navigator.of(context).pushNamed(
                                ClientProfile.routeName,
                                arguments: state.user,
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    // state.user.user!.photo == null
                                    // ?
                                    CircleAvatar(
                                      radius: 45.0,
                                      backgroundImage:
                                          AssetImage('assets/images/16.jpg'),
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MainScreen.routeName);
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
                          DrawerListTile('Products', 4, Icons.shop, () => {}),
                          DrawerListTile(
                            'Clients',
                            0,
                            Icons.person,
                            () => Navigator.of(context).pushNamed(
                              ClientsScreen.routeName,
                              arguments: state.user,
                            ),
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
                              ExapandedListItem('Collection Report', () {}),
                              ExapandedListItem('Order by debt', () {}),
                              ExapandedListItem('Customer by debt', () {}),
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
                              onTap: () => Navigator.of(context).pushNamed(
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
                                            backgroundImage: NetworkImage(
                                                state.user.user!.photo!),
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
                          DrawerListTile('Products', 4, Icons.shop, () => {}),
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
                              ExapandedListItem('Collection Report', () {}),
                              ExapandedListItem('Order by debt', () {}),
                              ExapandedListItem('Customer by debt', () {}),
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
    );
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
