import 'package:app/Blocs/reports/SalesRepor_cubit/bloc/sales_report_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainer extends StatefulWidget {
  @override
  _DataContainerState createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  late SalesReportBloc bloc;
  // ScrollController _scrollController = ScrollController();
  // int pages = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<SalesReportBloc>(context);
    bloc.add(FeatchSalesReportEvent());
    super.initState();
    // _scrollController.addListener(() {
    //   print(_scrollController.position.pixels);
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     pages = 2;
    //   }
    // });
  }

  // fetchFive() {
  //   for (int i = 0; i < 10; i++) {}
  // }

  @override
  void dispose() {
    bloc.close();
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReportBloc, SalesReportState>(
        builder: (context, state) {
      if (state is SalesReportInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is SalesReportLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is SalesReportSuccessState) {
        return ListView.separated(
            //controller: _scrollController,
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
                        text: 'ORDER',
                        dateApi: "${state.salesReport[index].orderNumber}",
                      ),
                      buildrowData(
                        text: 'CLIENT NAME',
                        dateApi:
                            "${state.salesReport[index].client!.firstName} ${state.salesReport[index].client!.lastName}",
                      ),
                      buildrowData(
                        text: 'TOTAL',
                        dateApi: "${state.salesReport[index].total}",
                      ),
                      buildrowData(
                        text: 'PAID',
                        dateApi: "${state.salesReport[index].amountPaid}",
                      ),
                      buildrowData(
                        text: 'DEBT',
                        dateApi: "${state.salesReport[index].amountRemaining}",
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
            //itemCount: cubit.saleReportModel!.data!.length,
            itemCount: state.salesReport.length);
      } else if (state is SalesReportErrorState) {
        return ErrorWidget(state.message.toString());
      }
      return Container();
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
