import 'dart:convert';

import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/clients_list/searchBar.dart';
import 'package:app/Widget/clients/clients_list/client.dart';
import 'package:app/constants/constants.dart';
import 'package:app/screens/client_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'drawer.dart';

class ClientsScreen extends StatefulWidget {
  static const routeName = 'client_screen';
  // final LoggedUserInfo user;

  ClientsScreen();
  // const ClientsScreen({
  //   required this.user,
  // });

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
              // arguments: widget.user,
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
        child: AppDrawer(),
      ),
      drawerEnableOpenDragGesture: true,
      body: Container(
        color: Color(0xFFf2f6f9),
        child: BlocBuilder<ClientsBloc, ClientsState>(
          builder: (context, state) {
            if (state is ClientFetchingSuccessState) {
              // state.products.map((product) {});
             

              return Column(
                children: [
                  SearchBar(),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'showing ${state.start} to ${state.end} of ${state.total} entries',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    child: LazyLoadScrollView(
                      onEndOfPage: () {},
                      child: ListView.builder(

                        itemCount: state.clients!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Client(
                            name: state.clients![index].firstName!,
                            mobile: state.clients![index].mobile!,
                            email: state.clients![index].email!,
                            status: state.clients![index].status.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ClientFetchingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ClientFetchingFailedState) {
              return Center(
                child: Text('Cient Fetch Failed'),
              );
            }
            return Center(
              child: Text('Cient Fetch Failed 1'),
            );
          },
        ),
      ),
    );
  }
}
