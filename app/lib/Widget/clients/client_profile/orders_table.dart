import 'package:app/models/navigation/order.dart';
import 'package:flutter/material.dart';

class Orderstable extends StatelessWidget {
  final List<Order> orders;

  Orderstable({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      
      child: Table(

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
          ...this.orders.map((order) => TableRow(children: [
                tableRowtext(order.date),
                tableRowtext(order.id),
                tableRowtext(order.total),
                tableRowtext(order.paid),
                tableRowtext(order.debt),
                tableRowtext(order.status),
              ]))
        ],
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
