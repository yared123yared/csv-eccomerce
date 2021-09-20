import 'package:app/Blocs/dashBoard/dailyChart/bloc/daily_chart_bloc.dart';
import 'package:app/Blocs/dashBoard/monthlyChart/bloc/monthly_chart_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FromToDashBoard extends StatefulWidget {
  @override
  State<FromToDashBoard> createState() => _FromToDashBoardState();
}

class _FromToDashBoardState extends State<FromToDashBoard> {
  bool isFormDate = false;
  bool isToDate = false;
  DateTime dateForm = DateTime.now();

  DateTime dateTo = DateTime.now();

  String? dateFromText = "";
  String dateToText = "";

  Future<Null> selectFormTimePicker(BuildContext context) async {
    setState(() {
      isFormDate = true;
    });
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateForm,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != dateForm) {
      setState(() {
        dateForm = picked;
        dateFromText =
            "${dateForm.day.toString()}-${dateForm.month.toString()}-${dateForm.year.toString()}";
      });

      print(dateFromText);
    }
  }

  Future<Null> selectToTimePicker(BuildContext context) async {
    setState(() {
      isToDate = true;
    });
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTo,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateTo) {
      setState(() {
        dateTo = picked;
        dateToText =
            "${dateTo.day.toString()}-${dateTo.month.toString()}-${dateTo.year.toString()}";

        print(dateToText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(180),
            ),
            //
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isFormDate
                      ? Text(
                          dateFromText.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff414e79),
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          cubit.tFrom(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff414e79),
                              fontWeight: FontWeight.bold),
                        ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        selectFormTimePicker(context);
                      });
                      BlocProvider.of<MonthlyChartBloc>(context).add(
                          FeatchMonthlyChartEvent(dateFromText.toString()));
                      BlocProvider.of<DailyChartBloc>(context)
                          .add(FeatchDailyChartEvent(dateFromText.toString()));
                    },
                    icon: Image.asset(
                      'assets/images/date.png',
                      width: 30,
                      height: 30,
                    ),
                    label: Text(
                      '',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(180),
            ),
            //
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isToDate
                      ? Text(
                          dateToText.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff414e79),
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          cubit.tTo(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff414e79),
                              fontWeight: FontWeight.bold),
                        ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        selectToTimePicker(context);
                      });
                      BlocProvider.of<MonthlyChartBloc>(context).add(
                          FeatchMonthlyChartEvent(dateFromText.toString()));
                      BlocProvider.of<DailyChartBloc>(context)
                          .add(FeatchDailyChartEvent(dateFromText.toString()));
                    },
                    icon: Image.asset(
                      'assets/images/date.png',
                      width: 30,
                      height: 30,
                    ),
                    label: Text(
                      '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
