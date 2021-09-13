import 'package:app/Blocs/orderDrawer/OrderByDebt/bloc/orderbydebt_bloc.dart';
import 'package:app/Widget/Orders/orderbyDebt/data_container.dart';
import 'package:app/Widget/Orders/orderbyDebt/search_container.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/OrdersDrawer/orderbyDebt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../drawer.dart';

class OrdersByDebtScreen extends StatefulWidget {
  static const routeName = "/orderByDebtScreen";

  @override
  _OrdersByDebtScreenState createState() => _OrdersByDebtScreenState();
}

class _OrdersByDebtScreenState extends State<OrdersByDebtScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<DataOrderByDebt> orderByDebtdata = [];

  late OrderbydebtBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<OrderbydebtBloc>(context);
    bloc.add(FeatchOrderbydebtEvent());
    // bloc.add(grandTotalEvent());

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
          "Orders By Debt",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        onPressed: (){},
      ),
      drawerEnableOpenDragGesture: true,
      backgroundColor: lightColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            child: SearchOrderBtDebt(),
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<OrderbydebtBloc, OrderbydebtState>(
            builder: (context, state) {
              if (state is OrderbydebtSuccessState) {
                return Text(
                  "Showing 1 to 5 of ${state.orderbydept.length} entries",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                );
              } else if (state is SearchOrderByDebtSccessState) {
                return Text(
                  "Showing 1 to 5 of ${state.searchOrderByDebt.length} entries",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                );
              } else {
                return Text(
                  "Showing 1 to 5 of 5 entries",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: DataContainerOrderByDebt(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Container(
              width: 400,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: BlocBuilder<OrderbydebtBloc, OrderbydebtState>(
                    builder: (context, state) {
                  if (state is OrderbydebtSuccessState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            buildText(text: "\$ ${state.grandTotalInt.sum}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "DEBT"),
                            buildText(text: "\$ ${state.debtTotalInt.sum}")
                          ],
                        ),
                      ],
                    );
                  } else if (state is SearchOrderByDebtSccessState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            buildText(
                                text: "\$ ${state.searchgrandTotalInt.sum}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "DEBT"),
                            buildText(
                                text: "\$ ${state.searchdebtTotalInt.sum}")
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            buildText(text: "\$ 00.00")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "DEBT"),
                            buildText(text: "\$ 00.00")
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText({required String text}) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
}
