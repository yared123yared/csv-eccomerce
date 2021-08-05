import 'package:app/Widget/clients/clients_list/searchBar.dart';
import 'package:app/Widget/clients/clients_list/client.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/navigation/client.dart';
import 'package:app/screens/client_new_screen.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class ClientsScreen extends StatefulWidget {
  static const routeName = 'client_screen';
  final LoggedUserInfo user;

  const ClientsScreen({
    required this.user,
  });

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Clients'),
        centerTitle: true,
        backgroundColor: primaryColor,
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
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              NewClientScreen.routeName,
              arguments: widget.user,
            ),
            icon: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue.shade700,
        ),
        child: AppDrawer(user: widget.user),
      ),
      drawerEnableOpenDragGesture: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchBar(),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'showing 1 to 5 of 5 entries',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Client(
            client: ClientData(
              name: 'Jhon Doe',
              mobile: '2378198774',
              email: 'ale@gmail.com',
              status: 'ACTIVE',
            ),
          ),
          Client(
            client: ClientData(
              name: 'Jhon Doe',
              mobile: '2378198774',
              email: 'ale@gmail.com',
              status: 'ACTIVE',
            ),
          ),
        ],
      ),
    );
  }
}
