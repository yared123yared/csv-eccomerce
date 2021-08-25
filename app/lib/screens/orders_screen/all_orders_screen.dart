import 'package:app/Blocs/orderDrawer/AllOrder/cubit/allorders_cubit.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/cubit/allorders_state.dart';
import 'package:app/Widget/Orders/allOrders/data_container.dart';
import 'package:app/Widget/Orders/allOrders/search_container.dart';
import 'package:app/Widget/Orders/allOrders/search_data_container.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../drawer.dart';

class AllOrdersScreen extends StatelessWidget {
  static const routeName = "/allOrdersScreen";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllOrdersCubit, AllOredersState>(
      builder: (context, state) {
        final cubit = AllOrdersCubit.get(context);

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
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
              Text(
                "Showing 1 to 5 of 5 entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              if (cubit.searchController.text.isEmpty)
                Expanded(
                  child: DataContainerAllOrders(),
                )
              else
                Expanded(child: SearchDataAllOrders())
            ],
          ),
        );
      },
    );
  }
}
