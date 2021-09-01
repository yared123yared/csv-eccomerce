import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/Widget/Orders/allOrders/data_container.dart';
import 'package:app/Widget/Orders/allOrders/search_container.dart';
import 'package:app/Widget/dashboard/daily_debt.dart';

import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
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

  late AllorderrBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AllorderrBloc>(context);
    bloc.add(FeatcAllorderrEvent());

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
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
