import 'package:app/Widget/dashboard/daily_chart.dart';
import 'package:app/Widget/dashboard/from_to_dashboard.dart';

import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';

class DailyDebt extends StatelessWidget {
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
                "Daily Debt Collection",
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
              bottomLeft: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              FromToDashBoard(),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 8,
              //       width: 20,
              //       decoration: BoxDecoration(
              //         color: Color(0xff858eab),
              //         border: Border.all(
              //           color: Color(0xff3c3759),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       "Total Collection",
              //       style: TextStyle(fontSize: 8),
              //     ),
              //   ],
              // ),
              DailyChart(),
            ],
          ),
        ),
      ],
    );
  }
}
