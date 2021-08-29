import 'package:app/Widget/dashboard/daily_chart.dart';

import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';

class ManthlyDebt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .94,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Monthly Debt Collection",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 350,
          width: MediaQuery.of(context).size.width * .94,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0)),
          ),
          child: Column(
            children: [
              DailyChart(),
            ],
          ),
        ),
      ],
    );
  }
}
