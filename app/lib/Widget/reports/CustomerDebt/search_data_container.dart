import 'package:app/Blocs/reports/CustomerDebt/cubit/customer_cubit.dart';
import 'package:app/Blocs/reports/CustomerDebt/cubit/customer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDataCustomDebt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDebtCubit, CustomerDebttState>(
      builder: (context, state) {
        final cubit = CustomerDebtCubit.get(context);
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
            itemCount: cubit.customReportModel.data!.length,
            itemBuilder: (context, index) {
              return buildCustomerText(
                nameCliebtText:
                    "${cubit.customReportModel.data![index].firstName} ${cubit.customReportModel.data![index].lastName}",
                totalClientText:
                    "\$ ${cubit.customReportModel.data![index].debts}",
              );
            },
          ),
        );
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
