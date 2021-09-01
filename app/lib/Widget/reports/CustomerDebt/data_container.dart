import 'package:app/Blocs/reports/CustomerDebt/bloc/custom_debt_bloc.dart';
import 'package:app/models/repoets_model/custom_report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataContainerCustomDebt extends StatefulWidget {
  DataContainerCustomDebt();
  @override
  _DataContainerCustomDebtState createState() =>
      _DataContainerCustomDebtState();
}

class _DataContainerCustomDebtState extends State<DataContainerCustomDebt> {
  late CustomDebtBloc bloc;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  List<DataCustomReport> dataCustomReport = [];
  int start = 0;
  int end = 0;
  int total = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<CustomDebtBloc>(context);
    bloc.add(FeatchCustomDebtEvent());
    super.initState();

    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value
          .map((item) => item.index)
          .toList();
      if (indices.length > 0) {
        setState(() {
          if (dataCustomReport.isNotEmpty) {
            if (dataCustomReport.length > 0) {
              start = indices[0] + 1;
              end = indices.length;
            }
          }
        });
      }
    });
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
        BlocBuilder<CustomDebtBloc, CustomDebtState>(
          builder: (context, state) {
            if (state is CustomDebtSuccessState) {
              return Text(
                "showing ${start} to ${end} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is SearchCustomDebtSuccessState) {
              return Text(
                "Showing 1 to 5 of ${state.searchcustomDebtData.length} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            }
            return Text("");
          },
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * .94,
              decoration: BoxDecoration(
                color: Color(0xffd9d9d9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "CLIENT",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "TOTAL",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width * .94,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0)),
              ),
              child: BlocBuilder<CustomDebtBloc, CustomDebtState>(
                builder: (context, state) {
                  if (state is CustomDebtInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CustomDebtLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CustomDebtSuccessState) {
                    dataCustomReport = state.customDebtData;
                    if (state.customDebtData.isNotEmpty) {
                      total = state.customDebtData.length;
                    }
                    return ScrollablePositionedList.builder(
                      itemCount: state.customDebtData.length,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemBuilder: (context, index) {
                        return buildCustomerText(
                          nameCliebtText:
                              "${state.customDebtData[index].firstName} ${state.customDebtData[index].lastName}",
                          totalClientText:
                              "\$ ${state.customDebtData[index].debts}",
                        );
                      },
                    );
                  } else if (state is SearchCustomDebtLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchCustomDebtSuccessState) {
                    return ListView.builder(
                      itemCount: state.searchcustomDebtData.length,
                      itemBuilder: (context, index) {
                        return buildCustomerText(
                          nameCliebtText:
                              "${state.searchcustomDebtData[index].firstName} ${state.searchcustomDebtData[index].lastName}",
                          totalClientText:
                              "\$ ${state.searchcustomDebtData[index].debts}",
                        );
                      },
                    );
                  } else if (state is CustomDebtErrorState) {
                    return ErrorWidget(state.message.toString());
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCustomerText(
          {required String nameCliebtText, required String totalClientText}) =>
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameCliebtText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Text(
              totalClientText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
}
