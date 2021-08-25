import 'package:app/Blocs/reports/SalesRepor_cubit/cubit/salesreport_cubit.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/cubit/salesreport_state.dart';
import 'package:app/Widget/reports/salesReport/data_container.dart';
import 'package:app/Widget/reports/salesReport/from_to_container.dart';
import 'package:app/Widget/reports/salesReport/search_container.dart';
import 'package:app/Widget/reports/salesReport/search_data_container.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../drawer.dart';

class SalesReportScreens extends StatelessWidget {
  static const routeName = '/salesReportScreens';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReportCubit, SalesReportState>(
      builder: (context, state) {
        final cubit = SalesReportCubit.get(context);
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
              "Sales Report",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          drawer: AppDrawer(),
          drawerEnableOpenDragGesture: true,
          backgroundColor: lightColor,
          body: Column(
            children: [
              Column(
                children: [
                  FromToContainer(),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(400, 40),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      cubit.clearAll();
                      // cubit.postSalesReport(
                      //   nameSearch: "",
                      //   dateFrom: "",
                      //   dateTo: "",
                      // );
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SearchContainer(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Showing 1 to 5 of 5 entries",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              if (cubit.dateFromText.isNotEmpty)
                Expanded(
                  child: SearchDataContainer(),
                )
              else if (cubit.dateToText.isNotEmpty)
                Expanded(
                  child: SearchDataContainer(),
                )
              else if (cubit.searchController.text.isNotEmpty)
                Expanded(
                  child: SearchDataContainer(),
                )
              else
                Expanded(
                  child: DataContainer(),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    minimumSize: const Size(400, 55),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Export",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildItem(int number) => Container(
        height: 100,
        width: double.infinity,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Items",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "$number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 50,
                endIndent: 0.9,
                color: Colors.black,
              ),
            ],
          ),
        ),
      );
}
