import 'package:app/Blocs/reports/SalesRepor_cubit/bloc/sales_report_bloc.dart';
import 'package:app/models/repoets_model/sales_report_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataContainer extends StatefulWidget {
  @override
  _DataContainerState createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  late SalesReportBloc bloc;

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  List<DataSaleReport> dataSalesReport = [];
  List<DataSaleReport> searchDataSalesReport = [];
  List<DataSaleReport> fromToSalesReport = [];
  int start = 0;
  int end = 0;
  int total = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<SalesReportBloc>(context);
    bloc.add(FeatchSalesReportEvent());
    super.initState();
    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (dataSalesReport.isNotEmpty) {
              if (dataSalesReport.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );

    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (searchDataSalesReport.isNotEmpty) {
              if (searchDataSalesReport.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );

    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (fromToSalesReport.isNotEmpty) {
              if (fromToSalesReport.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SalesReportBloc, SalesReportState>(
          builder: (context, state) {
            if (state is SalesReportSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is SearchSalesReportSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is FromToSalesReportSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else {
              return Text(
                "Showing 1 to 5 of 5 entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 15,
        ),
        BlocBuilder<SalesReportBloc, SalesReportState>(
            builder: (context, state) {
          if (state is SalesReportInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SalesReportLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SalesReportSuccessState) {
            dataSalesReport = state.salesReport;
            if (state.salesReport.isNotEmpty) {
              total = state.salesReport.length;
            }

            return Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: state.salesReport.length,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                            dateApi:
                                "${state.salesReport[index].amountRemaining}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is SearchSalesReportLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchSalesReportSuccessState) {
            searchDataSalesReport = state.searchSalesReport;
            if (state.searchSalesReport.isNotEmpty) {
              total = state.searchSalesReport.length;
            }
            return Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: state.searchSalesReport.length,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                            dateApi:
                                "${state.searchSalesReport[index].orderNumber}",
                          ),
                          buildrowData(
                            text: 'CLIENT NAME',
                            dateApi:
                                "${state.searchSalesReport[index].client!.firstName} ${state.searchSalesReport[index].client!.lastName}",
                          ),
                          buildrowData(
                            text: 'TOTAL',
                            dateApi: "${state.searchSalesReport[index].total}",
                          ),
                          buildrowData(
                            text: 'PAID',
                            dateApi:
                                "${state.searchSalesReport[index].amountPaid}",
                          ),
                          buildrowData(
                            text: 'DEBT',
                            dateApi:
                                "${state.searchSalesReport[index].amountRemaining}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is FromToSalesReportLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FromToSalesReportSuccessState) {
            fromToSalesReport = state.fromToSalesReport;
            if (state.fromToSalesReport.isNotEmpty) {
              total = state.fromToSalesReport.length;
            }
            return Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: state.fromToSalesReport.length,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                            dateApi:
                                "${state.fromToSalesReport[index].orderNumber}",
                          ),
                          buildrowData(
                            text: 'CLIENT NAME',
                            dateApi:
                                "${state.fromToSalesReport[index].client!.firstName} ${state.fromToSalesReport[index].client!.lastName}",
                          ),
                          buildrowData(
                            text: 'TOTAL',
                            dateApi: "${state.fromToSalesReport[index].total}",
                          ),
                          buildrowData(
                            text: 'PAID',
                            dateApi:
                                "${state.fromToSalesReport[index].amountPaid}",
                          ),
                          buildrowData(
                            text: 'DEBT',
                            dateApi:
                                "${state.fromToSalesReport[index].amountRemaining}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is SalesReportErrorState) {
            return ErrorWidget(state.message.toString());
          }
          return Container();
        }),
      ],
    );
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
