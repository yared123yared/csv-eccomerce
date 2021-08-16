import 'package:app/Blocs/reports/cubit/report_cubit.dart';
import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:app/Widget/reports/salesReport/data_container.dart';
import 'package:app/Widget/reports/salesReport/from_to_container.dart';
import 'package:app/Widget/reports/salesReport/search_container.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../drawer.dart';

class SalesReportScreens extends StatelessWidget {
  static const routeName = '/salesReportScreens';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final cubit = ReportCubit.get(context);
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
              cubit.isComeData
                  ? Expanded(
                      child: DataContainer(),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.51,
                      child: Center(
                        // ? Text(
                        //     " Please enter the correct search",
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 20,
                        //     ),
                        //   )
                        child: Text(
                          "No Data Yet",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    minimumSize: const Size(400, 55),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    cubit.isComeData = true;

                    cubit.postSalesReport(
                      searchText: cubit.searchController.text,
                      getFromDate: cubit.dateFromText,
                      getToDate: cubit.dateToText,
                    );
                  },
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
}
