import 'package:app/Blocs/reports/cubit/report_cubit.dart';
import 'package:app/Blocs/reports/cubit/report_state.dart';
import 'package:app/Widget/reports/sales_report/container_search_border.dart';
import 'package:app/Widget/reports/sales_report/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerByDebtScreen extends StatefulWidget {
  static const routeName = '/customerByDebt';
  @override
  _CustomerByDebtScreenState createState() => _CustomerByDebtScreenState();
}

class _CustomerByDebtScreenState extends State<CustomerByDebtScreen> {
  final itemsDropDownList = ["5", "10", "25", "50", "100"];

  String? value = "10";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final cubit = ReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Customer By Debt"),
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).accentColor,
          body: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
                      items: itemsDropDownList.map(buildMenuItems).toList(),
                      onChanged: (value) {
                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ContainerSearchBorder(
                  searchController: cubit.orderController,
                  text: "CLIENT",
                  height: 130,
                  width: 400,
                  textNum: Container(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 120,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xffd2dfea),
                    ),
                  ),
                  child: const Padding(
                    padding:  EdgeInsets.only(left: 15, top: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "TOTAL",
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
          ),
        );
      },
    );
  }
}
