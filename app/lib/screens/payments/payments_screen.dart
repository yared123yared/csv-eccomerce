import 'package:app/Blocs/Payments/patments_state.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:app/Widget/payments/amount_container.dart';
import 'package:app/Widget/payments/data_container.dart';
import 'package:app/Widget/payments/dateTime_container.dart';
import 'package:app/Widget/payments/search_container.dart';
import 'package:app/Widget/payments/upload_slip_container.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../drawer.dart';

class PaymentsScreen extends StatelessWidget {
  static const routeName = "/paymentsScreen";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
          "Upload Bank Slip",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
      backgroundColor: lightColor,
      body: BlocBuilder<PaymentsCubit, PaymentsState>(
        builder: (contest, state) {
          final cubit = PaymentsCubit.get(context);
          return Padding(
            padding: EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              children: [
                DateContainer(),

                // amount search
                SizedBox(
                  height: 15,
                ),

                AmountContainer(),

                SizedBox(
                  height: 15,
                ),

                UploadSlipContainer(),

                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    minimumSize: const Size(400, 40),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    cubit.uploadImage(
                      date: cubit.dateFromText,
                    );
                    Fluttertoast.showToast(
                        msg: "Successful Uploaded",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    cubit.clealuploade();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SearchPaymentScreen(),
                SizedBox(
                  height: 10,
                ),
                cubit.isComeData
                    ? Text(
                        "Showing 1 to 5 of 5 entries",
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
                  height: 20,
                ),

                Expanded(
                  child: DataPaymentsContainer(),
                ),
                // cubit.isComeData
                //     ? Expanded(
                //         child: DataPaymentsContainer(),
                //       )
                //     : Center(
                //         child: Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       ),
              ],
            ),
          );
        },
      ),
    );
  }
}
