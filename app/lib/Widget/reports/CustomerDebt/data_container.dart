import 'package:app/Blocs/reports/CustomerDebt/bloc/custom_debt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainerCustomDebt extends StatefulWidget {
  DataContainerCustomDebt();
  @override
  _DataContainerCustomDebtState createState() =>
      _DataContainerCustomDebtState();
}

class _DataContainerCustomDebtState extends State<DataContainerCustomDebt> {
  late CustomDebtBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CustomDebtBloc>(context);
    bloc.add(FeatchCustomDebtEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomDebtBloc, CustomDebtState>(
      builder: (context, state) {
        if (state is CustomDebtInitial) {
          return CircularProgressIndicator();
        } else if (state is CustomDebtLoadingState) {
          return CircularProgressIndicator();
        } else if (state is CustomDebtSuccessState) {
          return Container(
            height: 180,
            width: MediaQuery.of(context).size.width * .94,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
            ),
            child: ListView.builder(
              itemCount: state.customDebtData.length,
              itemBuilder: (context, index) {
                return buildCustomerText(
                  nameCliebtText:
                      "${state.customDebtData[index].firstName} ${state.customDebtData[index].lastName}",
                  totalClientText: "\$ ${state.customDebtData[index].debts}",
                );
              },
            ),
          );
        } else if (state is CustomDebtErrorState) {
          return ErrorWidget(state.message.toString());
        }
        return Container();
      },
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
