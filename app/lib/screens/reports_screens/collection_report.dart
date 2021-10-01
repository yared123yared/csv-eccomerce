import 'package:app/Widget/reports/CollectionReport/data_container.dart';
import 'package:app/Widget/reports/CollectionReport/from_to_container.dart';
import 'package:app/Widget/reports/CollectionReport/search_container.dart';
import 'package:app/constants/constants.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../drawer.dart';

class CollectionReportScreen extends StatelessWidget {
  static const routeName = '/collectionReportScreens';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
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
        title: Text(
          cubit.tCollectionReport(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        onPressed: () {},
      ),
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
              SizedBox(
                height: 10,
              ),
              SearchContainerColl(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          Expanded(
            child: DataContainerColl(),
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
              child: Text(
                cubit.tExport(),
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
  }
}
