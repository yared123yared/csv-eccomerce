import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_cubit.dart';
import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainerColl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionReportCubit, CollectionReportState>(
        builder: (context, state) {
      final cubit = CollectionReportCubit.get(context);
      final cubitData = cubit.collectionReportModel.data;
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
                  buildrowData(
                    text: 'PAYMENT DATE',
                    dateApi:
                        "${cubit.collectionReportModel.data![index].createdAt}",
                  ),
                  buildrowData(
                    text: 'PAYMENT METHOD',
                    dateApi:
                        "${cubit.collectionReportModel.data![index].paymentMethod}",
                  ),
                  buildrowData(
                    text: 'ORDER',
                    dateApi:
                        "${cubit.collectionReportModel.data![index].order!.orderNumber}",
                  ),
                  buildrowData(
                    text: 'CLIENT NAME',
                    dateApi:
                        '${cubitData![index].order!.client!.firstName} ${cubitData[index].order!.client!.lastName}',
                  ),
                  buildrowData(
                    text: 'PAID AMOUNT',
                    dateApi:
                        "${cubit.collectionReportModel.data![index].amountPaid}",
                  ),
                  buildrowData(
                    text: 'STATUS',
                    dateApi:
                        '${cubit.collectionReportModel.data![index].status}',
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
        itemCount: cubit.collectionReportModel.data!.length,
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
            padding: const EdgeInsets.only(top: 8, left: 10),
            child: Container(
              height: 30,
              width: 150,
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 15),
            child: Container(
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
          ),
        ],
      );
}
