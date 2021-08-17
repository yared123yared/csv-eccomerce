import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_cubit.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FromToContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReportCubit, SalesReportState>(
      builder: (context, state) {
        final cubit = SalesReportCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Row(
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
                      cubit.isFormDate
                          ? Text(
                              cubit.dateFromText,
                              //"${cubit.dateForm.day.toString()}-${cubit.dateForm.month.toString()}-${cubit.dateForm.year.toString()}",
                              //"${cubit.dateFromText}",
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
                          cubit.selectFormTimePicker(context);
                          cubit.postSalesReport(
                            nameSearch: "",
                            dateFrom: cubit.dateForm.toString(),
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
                      cubit.isToDate
                          ? Text(
                              cubit.dateToText,
                              //"${cubit.dateTo.day.toString()}-${cubit.dateTo.month.toString()}-${cubit.dateTo.year.toString()}",
                              //"${cubit.dateToText}",
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
                          
                          cubit.selectToTimePicker(context);
                          cubit.postSalesReport(
                            nameSearch: "",
                            dateFrom: cubit.dateForm.toString(),
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
        );
      },
    );
  }
}
