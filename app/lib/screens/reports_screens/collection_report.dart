import 'package:app/Blocs/reports/cubit/report_cubit.dart';
import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:app/Widget/reports/sales_report/container_search_border.dart';
import 'package:app/Widget/reports/sales_report/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionReportScreen extends StatefulWidget {
  static const routeName = '/collectionReport';
  @override
  _CollectionReportScreenState createState() => _CollectionReportScreenState();
}

class _CollectionReportScreenState extends State<CollectionReportScreen> {
  final itemsDropDownList = ["5", "10", "25", "50", "100"];
  final itemsStatus = ["All", "Pending", "Approved"];

  String? value = "10";
  String? valueStatus = "All";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final cubit = ReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Collection Report"),
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
                            cubit.isFormDate
                                ? Text(
                                    "${cubit.dateForm.day.toString()}/${cubit.dateForm.month.toString()}/${cubit.dateForm.year.toString()}",
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
                                cubit.selectFormTimePicker(context);
                              },
                              icon: Icon(Icons.date_range),
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
                      const SizedBox(
                        width: 20,
                      ),
                      containerBorder(
                        height: 40,
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (cubit.isToDate) Text(
                                    "${cubit.dateTo.day.toString()}/${cubit.dateTo.month.toString()}/${cubit.dateTo.year.toString()}",
                                    style: const TextStyle(
                                      color:  Color(0xff414e79),
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
                                cubit.selectToTimePicker(context);
                              },
                              icon: const Icon(Icons.date_range),
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
                                "PAYMENT DATE",
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
                                child: const Text(
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
                              if (cubit.isDate) Text(
                                      "${cubit.dateDATE.day.toString()}/${cubit.dateDATE.month.toString()}/${cubit.dateDATE.year.toString()}",
                                      style: const TextStyle(
                                        color: Color(0xff414e79),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ) else const Text(
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
                                icon: const Icon(Icons.date_range),
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
                    text: "PAYMENT METHOD",
                    height: 130,
                    width: 400,
                    textNum: Container(),
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
                    searchController: cubit.orderController,
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
                    text: "PAID AMOUNT",
                    height: 170,
                    width: 400,
                    textNum: const Text(
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
                  Container(
                    height: 120,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xffd2dfea),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:  EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            "STATUS",
                            style: TextStyle(
                              color: Color(0xff414e79),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.white,
                              value: valueStatus,
                              items: itemsStatus.map(buildMenuItems).toList(),
                              onChanged: (value) {
                                setState(() {
                                  this.valueStatus = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xffd2dfea),
                          ),
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "DENY REASON	",
                              style: TextStyle(
                                color: Color(0xff414e79),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xffd2dfea),
                          ),
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "ACTIONS",
                              style: TextStyle(
                                color: Color(0xff414e79),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
