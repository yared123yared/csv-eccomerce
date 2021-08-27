import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_cubit.dart';
import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_state.dart';
import 'package:app/Widget/reports/CollectionReport/data_container.dart';
import 'package:app/Widget/reports/CollectionReport/from_to_container.dart';
import 'package:app/Widget/reports/CollectionReport/search_container.dart';
import 'package:app/Widget/reports/CollectionReport/search_data_container.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../drawer.dart';

class CollectionReportScreen extends StatelessWidget {
  static const routeName = '/collectionReportScreens';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionReportCubit, CollectionReportState>(
      builder: (context, state) {
        final cubit = CollectionReportCubit.get(context);
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
              "Collection Report",
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
                  FromToContainerColle(),
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
                  SearchContainerColl(),
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
              Expanded(
                child: DataContainerColl(),
              ),
              // cubit.isComeData
              //     ? Expanded(
              //         child: DataContainerColl(),
              //       )
              //     : Container(
              //         height: MediaQuery.of(context).size.height * 0.51,
              //         child: Center(
              //           child: Center(
              //             child: CircularProgressIndicator(),
              //           ),
              //         ),
              //       ),
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
}
