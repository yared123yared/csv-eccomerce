import 'package:app/Widget/reports/salesReport/data_container.dart';
import 'package:app/Widget/reports/salesReport/export_button.dart';
import 'package:app/Widget/reports/salesReport/from_to_container.dart';
import 'package:app/Widget/reports/salesReport/search_container.dart';
import 'package:app/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../drawer.dart';

class SalesReportScreens extends StatefulWidget {
  static const routeName = '/salesReportScreens';

  @override
  _SalesReportScreensState createState() => _SalesReportScreensState();
}

class _SalesReportScreensState extends State<SalesReportScreens> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController itemScrollController = ItemScrollController();

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
                height: 10,
              ),
              SearchContainer(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          Expanded(child: DataContainer()),

          ///Export
          ExportButton(),
        ],
      ),
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
