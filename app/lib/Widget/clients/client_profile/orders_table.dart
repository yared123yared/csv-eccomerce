import 'package:app/models/client.dart';
import 'package:flutter/material.dart';

class Orderstable extends StatelessWidget {
  final List<Orders> orders;

  Orderstable({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                tableHeadertext('DATE'),
                tableHeadertext('ID'),
                tableHeadertext('TOTAL'),
                tableHeadertext('PAID'),
                tableHeadertext('DEBT'),
                tableHeadertext('STATUS'),
              ],
            ),
            ...this.orders.map(
              (order) {
                String status = "UNKOWN";
                if (order.requiresApproval == 1) {
                  status = "APROVED";
                }
                return TableRow(
                  children: [
                    tableRowtext(order.paymentWhen.toString()),
                    tableRowtext(order.id.toString()),
                    tableRowtext(order.total.toString()),
                    tableRowtext(order.amountPaid.toString()),
                    tableRowtext(order.amountRemaining.toString()),
                    tableRowtext(order.status.toString()),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Text tableHeadertext(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}

Text tableRowtext(String title) {
  return Text(title, textAlign: TextAlign.center);
}
