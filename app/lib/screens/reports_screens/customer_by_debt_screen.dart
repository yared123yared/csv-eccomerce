import 'package:app/Blocs/reports/cubit/report_cubit.dart';
import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerByDebtScreen extends StatefulWidget {
  static const routeName = '/customerByDebt';
  @override
  _CustomerByDebtScreenState createState() => _CustomerByDebtScreenState();
}

class _CustomerByDebtScreenState extends State<CustomerByDebtScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        //final cubit = ReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Customer By Debt"),
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).accentColor,
          body: Center(
            child: Text(
              "Customer By Debt",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
