import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_cubit.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_state.dart';
import 'package:app/constants/constants.dart';
import 'package:app/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerByDebtScreen extends StatelessWidget {
  static const routeName = '/customerByDebt';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReportCubit, SalesReportState>(
      builder: (context, state) {
        //final cubit = ReportCubit.get(context);
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
              "Customer By Debt",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          drawer: AppDrawer(),
          drawerEnableOpenDragGesture: true,
          backgroundColor: lightColor,
        );
      },
    );
  }
}
