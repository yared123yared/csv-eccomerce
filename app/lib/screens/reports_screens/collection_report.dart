import 'package:app/Blocs/reports/cubit/report_cubit.dart';
import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionReportScreen extends StatefulWidget {
  static const routeName = '/collectionReport';
  @override
  _CollectionReportScreenState createState() => _CollectionReportScreenState();
}

class _CollectionReportScreenState extends State<CollectionReportScreen> {
  final itemsDropDownList = ["5", "10", "25", "50", "100"];
  final itemsStatus = ["All", "Pending", "Approved"];

  String? value = "10";
  String? valueStatus = "All";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final cubit = ReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Collection Report"),
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).accentColor,
          body: Center(
            child: Text(
              "Collection Report",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
