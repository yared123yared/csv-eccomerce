import 'package:app/Blocs/reports/cubit/report_cubit.dart';
import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:app/Widget/reports/sales_report/container_search_border.dart';
import 'package:app/Widget/reports/sales_report/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesReportScreen extends StatefulWidget {
  static const routeName = '/salesReport';

  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  final itemsDropDownList = ["5", "10", "25", "50", "100"];

  String? value = "10";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final cubit = ReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Sales Report"),
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).accentColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffd2dfea),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: value,
                            items:
                                itemsDropDownList.map(buildMenuItems).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          salesReportButton(
                            onpressed: () {
                              cubit.clearAll();
                            },
                            text: "Clear",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          salesReportButton(
                            onpressed: () {},
                            text: "Export",
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Text(
                        "From",
                        style: TextStyle(
                          color: Color(0xff414e79),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      containerBorder(
                        height: 40,
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (cubit.isFormDate) Text(
                                    "${cubit.dateForm.day.toString()}/${cubit.dateForm.month.toString()}/${cubit.dateForm.year.toString()}",
                                    style: const TextStyle(
                                      color: Color(0xff414e79),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ) else const Text(
                                    "dd/mm/yyyy",
                                    style: TextStyle(
                                      color: Color(0xff414e79),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                            const SizedBox(
                              width: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.selectFormTimePicker(context);
                              },
                              icon: const Icon(Icons.date_range),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "To      ",
                        style: TextStyle(
                          color: Color(0xff414e79),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      containerBorder(
                        height: 40,
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cubit.isToDate
                                ? Text(
                                    "${cubit.dateTo.day.toString()}/${cubit.dateTo.month.toString()}/${cubit.dateTo.year.toString()}",
                                    style: TextStyle(
                                      color: Color(0xff414e79),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  )
                                : Text(
                                    "dd/mm/yyyy",
                                    style: TextStyle(
                                      color: Color(0xff414e79),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                            SizedBox(
                              width: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.selectToTimePicker(context);
                              },
                              icon: Icon(Icons.date_range),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  containerBorder(
                    height: 110,
                    width: 400,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "DATE",
                                style: TextStyle(
                                  color: Color(0xff414e79),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  cubit.clearDateOnly();
                                },
                                child: Text(
                                  "clear",
                                  style: TextStyle(
                                    color: Color(0xff4354c3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        containerBorder(
                          height: 40,
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cubit.isDate
                                  ? Text(
                                      "${cubit.dateDATE.day.toString()}/${cubit.dateDATE.month.toString()}/${cubit.dateDATE.year.toString()}",
                                      style: TextStyle(
                                        color: Color(0xff414e79),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                  : Text(
                                      "dd/mm/yyyy",
                                      style: TextStyle(
                                        color: Color(0xff414e79),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                              IconButton(
                                onPressed: () {
                                  cubit.selectDateTimePicker(context);
                                },
                                icon: Icon(Icons.date_range),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContainerSearchBorder(
                    searchController: cubit.orderController,
                    text: "ORDER #",
                    height: 130,
                    width: 400,
                    textNum: Container(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContainerSearchBorder(
                    searchController: cubit.clientNameController,
                    text: "CLIENT NAME",
                    height: 130,
                    width: 400,
                    textNum: Container(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContainerSearchBorder(
                    searchController: cubit.totalController,
                    text: "TOTAL",
                    height: 170,
                    width: 400,
                    textNum: Text(
                      "\$0.00",
                      style: TextStyle(
                        color: Color(0xff414e79),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContainerSearchBorder(
                    searchController: cubit.paidController,
                    text: "PAID",
                    height: 170,
                    width: 400,
                    textNum: Text(
                      "\$0.00",
                      style: TextStyle(
                        color: Color(0xff414e79),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContainerSearchBorder(
                    searchController: cubit.debtController,
                    text: "DEBT",
                    height: 170,
                    width: 400,
                    textNum: Text(
                      "\$0.00",
                      style: TextStyle(
                        color: Color(0xff414e79),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
