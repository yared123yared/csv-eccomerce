import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/login_info.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/dashBorad_screen.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/orders_screen/all_orders_screen.dart';
import 'package:app/screens/payments/payments_screen.dart';
import 'package:app/screens/reports_screens/collection_report.dart';
import 'package:app/screens/reports_screens/customer_by_debt_screen.dart';
import 'package:app/screens/reports_screens/salesReport_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  FetchClientsEvent fetchClientEvent = new FetchClientsEvent(loadMore: false);
  final String baseUrl = 'http://csv.jithvar.com/storage';

  void navigateToHomeScreen(
      BuildContext context, LoggedUserInfo? loggedUserInfo) {
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.pushNamed(context, MainScreen.routeName,
        arguments: loggedUserInfo);
  }

  void navigateToClientScreen(BuildContext context) {
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.pushNamed(context, ClientsScreen.routeName);
  }

  void navigateToInvoiceClientScreen(BuildContext context) {
    // BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientEvent);
    Navigator.pushReplacementNamed(context, InvoiceClientSearch.routeName);
  }

  String photoPath = "assets/images/circular.png";

  @override
  Widget build(BuildContext context) {
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
                                    // Navigator.of(context).pushNamed(
                                    //   ClientProfile.routeName,
                                    //   arguments: state.user,
                                    // );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        photo,
                                        // CircleAvatar(
                                        //   radius: 45.0,
                                        //   backgroundImage:
                                        //       AssetImage(photoPath),
                                        // ),
                                        // ignore: todo
                                        //TODO nullcheck
                                        Text(
                                          '${state.user.user!.firstName}',
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
                                      //

                                      Navigator.pushNamed(
                                          context, MainScreen.routeName,
                                          arguments: 0);

                                      // widget.onPressed();
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
                              // DrawerListTile(
                              //   'Shop',
                              //   0,
                              //   Icons.list_alt,
                              //   () => {},
                              // ),
                              // DrawerListTile(
                              //     'Products', 4, Icons.shop, () => {}),
                              // DrawerListTile(
                              //   'Clients',
                              //   0,
                              //   Icons.person,
                              //   // () => setState(() {
                              //   // this.check = 7;
                              //   // BlocProvider.of<ClientsBloc>(context,
                              //   //         listen: false)
                              //   //     .add(fetchClientEvent);
                              //   // }),
                              //   () => navigateToClientScreen(context),
                              // ),

                              // DrawerListTile(
                              //     'Shop',
                              //     0,
                              //     Icons.production_quantity_limits_sharp,
                              //     () => () {
                              //           Navigator.pushNamed(
                              //               context, MainScreen.routeName,
                              //               arguments: 1);
                              //         }),
                              //walid
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
                                      //

                                      Navigator.pushNamed(
                                          context, MainScreen.routeName,
                                          arguments: 1);

                                      // widget.onPressed();
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
                                                    'https://csv.jithvar.com/storage/${state.user.user!.photo!.filePath.toString()}'),
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
                              // Container(
                              //   margin: EdgeInsets.only(right: 25),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(30),
                              //       bottomRight: Radius.circular(30),
                              //     ),
                              //   ),
                              //   child: InkWell(
                              //     child: ListTile(
                              //       leading: Icon(
                              //         Icons.home,
                              //         size: 40.0,
                              //         color: Colors.black,
                              //       ),
                              //       title: Text(
                              //         'Dashboard',
                              //         style: TextStyle(
                              //           // color: Colors.black,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20.0,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              InkWell(
                                child: DrawerListTile(
                                    'Dashboard', 0, Icons.home, () => {}),
                              ),
                              InkWell(
                                child: DrawerListTile(
                                  'Categories',
                                  0,
                                  Icons.list_alt,
                                  () => {},
                                ),
                              ),
                              InkWell(
                                child: DrawerListTile(
                                    'Products', 4, Icons.shop, () => {}),
                              ),
                              DrawerListTile(
                                'Clients',
                                4,
                                Icons.person,
                                () => {
                                  Navigator.of(context).pushNamed(
                                    ClientsScreen.routeName,
                                    arguments: state.user,
                                  ),
                                  BlocProvider.of<ClientsBloc>(context,
                                          listen: false)
                                      .add(fetchClientEvent),
                                },
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
