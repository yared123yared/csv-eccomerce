import 'package:app/Blocs/reports/CustomerDebt/customer_cubit.dart';
import 'package:app/Blocs/reports/CustomerDebt/customer_state.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_cubit.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_state.dart';
import 'package:app/Widget/reports/CustomerDebt/search_container.dart';
import 'package:app/constants/constants.dart';
import 'package:app/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerByDebtScreen extends StatelessWidget {
  static const routeName = '/customerByDebt';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDebtCubit, CustomerDebttState>(
      builder: (context, state) {
        final cubit = CustomerDebtCubit.get(context);
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height: 5.0,
                width: 5.0,
                child: ImageIcon(
                  AssetImage('assets/images/left-align.png'),
                ),
              ),
            ),
            title: const Text(
              "Customer By Debt",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          drawer: AppDrawer(),
          drawerEnableOpenDragGesture: true,
          backgroundColor: lightColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                child: SearchCustomerDebt(),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 25,
              ),
              cubit.isComeData
                  ? Text(
                      "Showing 1 to 5 of ${cubit.customReportModel.total} entries",
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    )
                  : Text(
                      "Showing 1 to 5 of 5 entries",
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .94,
                    decoration: BoxDecoration(
                      color: Color(0xffd9d9d9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CLIENT",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "TOTAL",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (cubit.isComeData)
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * .94,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                      ),
                      child: ListView.builder(
                        itemCount: cubit.customReportModel.data!.length,
                        itemBuilder: (context, index) {
                          return buildCustomerText(
                            nameCliebtText:
                                "${cubit.customReportModel.data![index].firstName} ${cubit.customReportModel.data![index].lastName}",
                            totalClientText:
                                "\$ ${cubit.customReportModel.data![index].debts}",
                          );
                        },
                      ),
                    )
                  else if (cubit.isComeData)
                    Center(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Data Yet",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildCustomerText(
          {required String nameCliebtText, required String totalClientText}) =>
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameCliebtText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Text(
              totalClientText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
}
