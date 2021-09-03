import 'package:app/Blocs/reports/SalesRepor_cubit/bloc/sales_report_bloc.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FromToContainer extends StatefulWidget {
  @override
  _FromToContainerState createState() => _FromToContainerState();
}

class _FromToContainerState extends State<FromToContainer> {
  bool isFormDate = false;
  bool isToDate = false;
  DateTime dateForm = DateTime.now();

  DateTime dateTo = DateTime.now();

  String dateFromText = "";
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
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(180),
                ),
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
                                color: Color(0xff414e79),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          : Text(
                              "From",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black45,
                              ),
                            ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selectFormTimePicker(context);
                          });

                          BlocProvider.of<SalesReportBloc>(context).add(
                            FromToReportEvent(
                                fromDate: dateFromText.toString(),
                                toDate: dateToText.toString()),
                          );
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
                height: 55,
                width: MediaQuery.of(context).size.width * 0.44,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                                color: Color(0xff414e79),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          : Text(
                              "To",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black45,
                              ),
                            ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selectToTimePicker(context);
                          });
                          BlocProvider.of<SalesReportBloc>(context).add(
                            FromToReportEvent(
                                fromDate: dateFromText.toString(),
                                toDate: dateToText.toString()),
                          );
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
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              minimumSize: const Size(400, 40),
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              setState(() {
                isFormDate = false;
                isToDate = false;
              });
            },
            child: const Text(
              "Clear",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
