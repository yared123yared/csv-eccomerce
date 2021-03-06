import 'package:app/Widget/reports/CustomerDebt/data_container.dart';
import 'package:app/Widget/reports/CustomerDebt/search_container.dart';

import 'package:app/constants/constants.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerByDebtScreen extends StatefulWidget {
  static const routeName = '/customerByDebt';

  @override
  _CustomerByDebtScreenState createState() => _CustomerByDebtScreenState();
}

class _CustomerByDebtScreenState extends State<CustomerByDebtScreen> {
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
          cubit.tCustomerByDebt(),
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
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            child: SearchCustomerDebt(),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 25,
          ),
          DataContainerCustomDebt(),
        ],
      ),
    );
  }
}
