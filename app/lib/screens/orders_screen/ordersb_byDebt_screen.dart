import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_cubit.dart';
import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_state.dart';
import 'package:app/Widget/Orders/orderbyDebt/data_container.dart';
import 'package:app/Widget/Orders/orderbyDebt/search_container.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../drawer.dart';

class OrdersByDebtScreen extends StatelessWidget {
  static const routeName = "/orderByDebtScreen";

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          "Orders By Debt",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
      backgroundColor: lightColor,
      body: BlocBuilder<OrderByDebtCubit, OrderByDebtState>(
        builder: (context, index) {
          final cubit = OrderByDebtCubit.get(context);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: SearchOrderBtDebt(),
              ),
              SizedBox(
                height: 30,
              ),
              cubit.isComeData
                  ? Text(
                      "Showing 1 to 5 of ${cubit.orderByDebtModel.total} entries",
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    )
                  : Text(
                      "Showing 1 to 5 of 5 entries",
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              if (cubit.isComeData)
                Expanded(
                  child: DataContainerOrderByDebt(),
                )
              else if (cubit.isComeDataWrong)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No Data Yet",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Container(
                  height: MediaQuery.of(context).size.height * 0.51,
                  child: Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            buildText(text: "\$ ${cubit.grandTotalInt.sum}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "DEBT"),
                            buildText(text: "\$ ${cubit.debtTotalInt.sum}")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
