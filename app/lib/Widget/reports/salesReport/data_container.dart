import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_cubit.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainer extends StatefulWidget {
  @override
  _DataContainerState createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReportCubit, SalesReportState>(
        builder: (context, state) {
      final cubit = SalesReportCubit.get(context);
      final cubitData = cubit.saleReportModel.data;

      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: 400,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // buildrowData(
                  //   text: 'DATE',
                  //   dateApi: "${cubit.saleReportModel.data![index].createdAt}",
                  // ),
                  buildrowData(
                    text: 'ORDER',
                    dateApi:
                        "${cubit.saleReportModel.data![index].orderNumber}",
                  ),
                  buildrowData(
                    text: 'CLIENT NAME',
                    dateApi:
                        "${cubitData![index].client!.firstName} ${cubitData[index].client!.lastName} ",
                  ),
                  buildrowData(
                    text: 'TOTAL',
                    dateApi: '${cubitData[index].total}',
                  ),
                  buildrowData(
                    text: 'PAID',
                    dateApi: '${cubitData[index].amountPaid}',
                  ),
                  buildrowData(
                    text: 'DEBT',
                    dateApi: '${cubitData[index].amountRemaining}',
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: cubit.saleReportModel.data!.length,
      );
    });
  }

  Widget buildrowData({
    required String text,
    required String dateApi,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: 10,
            ),
            child: Container(
              height: 30,
              width: 150,
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 150,
            child: Text(
              dateApi,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
}
