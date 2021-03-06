import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/db/db.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/login_info.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/orders_screen/all_orders_screen.dart';
import 'package:app/screens/payments/payments_screen.dart';
import 'package:app/screens/reports_screens/collection_report.dart';
import 'package:app/screens/reports_screens/customer_by_debt_screen.dart';
import 'package:app/screens/reports_screens/salesReport_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'invoice-client-search-screen.dart';
import 'orders_screen/ordersb_byDebt_screen.dart';

// import 'home_screen.dart';

UserPreferences pref = UserPreferences();

class AppDrawer extends StatefulWidget {
  final Function onPressed;
  AppDrawer({required this.onPressed});
  // late int selectedDrawer;

  // AppDrawer({
  //   required this.selectedDrawer,
  // });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late CartBloc cartBloc;
  @override
  void initState() {
    super.initState();
  }

  FetchClientsEvent fetchClientEvent = new FetchClientsEvent(loadMore: false);
  final String baseUrl = 'http://csv.jithvar.com/storage';

  void navigateToHomeScreen(
      BuildContext context, LoggedUserInfo? loggedUserInfo) {
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.pushReplacementNamed(context, MainScreen.routeName,
        arguments: loggedUserInfo);
  }

  void navigateToClientScreen(BuildContext context) {
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.popAndPushNamed(context, ClientsScreen.routeName);
  }

  void navigateToInvoiceClientScreen(BuildContext context) {
    // BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.popAndPushNamed(context, InvoiceClientSearch.routeName);
  }

  String photoPath = "assets/images/circular.png";

  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    Widget photo;
    final cubit = BlocProvider.of<LanguageCubit>(context);

    return Theme(
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
                  photoPath = state.user.user?.photo?.filePath ?? photoPath;
                  if (state.user.user != null) {
                    if (state.user.user!.photo != null) {
                      if (state.user.user!.photo!.filePath != null) {
                        photoPath =
                            state.user.user?.photo?.filePath ?? photoPath;

                        photo = CircleAvatar(
                          radius: 45,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              imageUrl: '${baseUrl}/${photoPath}',
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                color: Colors.white,
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.black,
                                child: Icon(Icons.error),
                              ),
                            ),
                            // child: Image.network('${baseUrl}/${client.photoPath}'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        );
                      } else {
                        photo = CircleAvatar(
                          radius: 45,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset('assets/images/circular.png'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        );
                      }
                    } else {
                      photo = CircleAvatar(
                        radius: 45,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset('assets/images/circular.png'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      );
                    }
                  } else {
                    photo = CircleAvatar(
                      radius: 45,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset('assets/images/circular.png'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    );
                  }
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
                                  onTap: () {
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        photo,
                                        Text(
                                          '${state.user.user?.firstName}',
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
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      Navigator.popAndPushNamed(
                                          context, MainScreen.routeName,
                                          arguments: 0);
                                    });
                                  },
                                  leading: Icon(
                                    Icons.home,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    cubit.tDashBoard(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 25),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      Navigator.popAndPushNamed(
                                          context, MainScreen.routeName,
                                          arguments: 1);
                                    });
                                  },
                                  leading: Icon(
                                    Icons.production_quantity_limits_sharp,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    cubit.tShop(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              DrawerExpansionTile(
                                cubit.tOrders(),
                                [
                                  ExapandedListItem(cubit.tAllOrders(), () {
                                    Navigator.of(context)
                                        .popAndPushNamed(AllOrdersScreen.routeName);
                                  }),
                                  ExapandedListItem(cubit.tOrdersByDebt(), () {
                                    Navigator.of(context).popAndPushNamed(
                                        OrdersByDebtScreen.routeName);
                                  }),
                                ],
                                0,
                                Icons.shopping_bag,
                              ),
                              DrawerExpansionTile(
                                cubit.tPayments(),
                                [
                                  ExapandedListItem(cubit.tBankDeposit(), () {
                                    Navigator.of(context)
                                        .popAndPushNamed(PaymentsScreen.routeName);
                                  }),
                                ],
                                0,
                                Icons.payment,
                              ),
                              DrawerExpansionTile(
                                cubit.tReports(),
                                [
                                  ExapandedListItem(cubit.tSalesReport(), () {
                                    Navigator.of(context).pushNamed(
                                        SalesReportScreens.routeName);
                                  }),
                                  ExapandedListItem(cubit.tCollectionReport(),
                                      () {
                                    Navigator.of(context).pushNamed(
                                        CollectionReportScreen.routeName);
                                  }),
                                  ExapandedListItem(cubit.tCustomerByDebt(),
                                      () {
                                    Navigator.of(context).pushNamed(
                                        CustomerByDebtScreen.routeName);
                                  }),
                                ],
                                0,
                                Icons.insights,
                              ),

                              DrawerExpansionTile(
                                cubit.tClientManagement(),
                                [
                                  ExapandedListItem(cubit.tClients(),
                                      () => navigateToClientScreen(context)),
                                  ExapandedListItem(
                                      cubit.tInvoices(),
                                      () => navigateToInvoiceClientScreen(
                                          context)),
                                ],
                                0,
                                Icons.handyman,
                              ), // DrawerHeader(child: )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          UserPreferences pref =
                              await UserPreferences();
                          pref.logOut(true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => Login(),
                              ),
                              (route) => false);
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
                              cubit.tSignout(),
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
                  photoPath = state.user.user?.photo?.filePath ?? photoPath;
                  if (state.user.user != null) {
                    if (state.user.user!.photo != null) {
                      if (state.user.user!.photo!.filePath != null) {
                        photoPath =
                            state.user.user?.photo?.filePath ?? photoPath;

                        photo = CircleAvatar(
                          radius: 45,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              imageUrl: '${baseUrl}/${photoPath}',
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                color: Colors.white,
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.black,
                                child: Icon(Icons.error),
                              ),
                            ),
                            // child: Image.network('${baseUrl}/${client.photoPath}'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        );
                      } else {
                        photo = CircleAvatar(
                          radius: 45,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset('assets/images/circular.png'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        );
                      }
                    } else {
                      photo = CircleAvatar(
                        radius: 45,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset('assets/images/circular.png'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      );
                    }
                  } else {
                    photo = CircleAvatar(
                      radius: 45,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset('assets/images/circular.png'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    );
                  }
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
                                  onTap: () { },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        photo,
                                        Text(
                                          '${state.user.user?.firstName}',
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
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      Navigator.popAndPushNamed(
                                          context, MainScreen.routeName,
                                          arguments: 0);
                                    });
                                  },
                                  leading: Icon(
                                    Icons.home,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    cubit.tDashBoard(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 25),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      Navigator.popAndPushNamed(
                                          context, MainScreen.routeName,
                                          arguments: 1);
                                    });
                                  },
                                  leading: Icon(
                                    Icons.production_quantity_limits_sharp,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    cubit.tShop(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              DrawerExpansionTile(
                                cubit.tOrders(),
                                [
                                  ExapandedListItem(cubit.tAllOrders(), () {
                                    Navigator.of(context)
                                        .pushNamed(AllOrdersScreen.routeName);
                                  }),
                                  ExapandedListItem(cubit.tOrdersByDebt(), () {
                                    Navigator.of(context).pushNamed(
                                        OrdersByDebtScreen.routeName);
                                  }),
                                ],
                                0,
                                Icons.shopping_bag,
                              ),
                              DrawerExpansionTile(
                                cubit.tPayments(),
                                [
                                  ExapandedListItem(cubit.tBankDeposit(), () {
                                    Navigator.of(context)
                                        .pushNamed(PaymentsScreen.routeName);
                                  }),
                                ],
                                0,
                                Icons.payment,
                              ),
                              DrawerExpansionTile(
                                cubit.tReports(),
                                [
                                  ExapandedListItem(cubit.tSalesReport(), () {
                                    Navigator.of(context).pushNamed(
                                        SalesReportScreens.routeName);
                                  }),
                                  ExapandedListItem(cubit.tCollectionReport(),
                                      () {
                                    Navigator.of(context).pushNamed(
                                        CollectionReportScreen.routeName);
                                  }),
                                  ExapandedListItem(cubit.tCustomerByDebt(),
                                      () {
                                    Navigator.of(context).pushNamed(
                                        CustomerByDebtScreen.routeName);
                                  }),
                                ],
                                0,
                                Icons.insights,
                              ),

                              DrawerExpansionTile(
                                cubit.tClientManagement(),
                                [
                                  ExapandedListItem(cubit.tClients(),
                                      () => navigateToClientScreen(context)),
                                  ExapandedListItem(
                                      cubit.tInvoices(),
                                      () => navigateToInvoiceClientScreen(
                                          context)),
                                ],
                                0,
                                Icons.handyman,
                              ), // DrawerHeader(child: )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          UserPreferences pref = await UserPreferences();
                          pref.logOut(true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => Login(),
                              ),
                              (route) => false);
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
                              cubit.tSignout(),
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
                }
                return Text('Login');
              },
            ),
          ),
        ));
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

  InkWell ExapandedListItem(
    String title,
    Function onTap,
  ) {
    return InkWell(
      onTap: () {
        onTap();
      },
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
