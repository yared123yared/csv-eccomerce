import 'package:flutter/material.dart';

import 'payment-custome-dropdown.dart';
import 'payment-filed-container.dart';
import 'payment-method-dropdown.dart';
import 'payment-time-payment-dropdown.dart';
import 'payment-type-wallet.dart';

class PaymentContainer extends StatelessWidget {
  // final TextEditingController payingTimeController;
  // PaymentContainer({required this.payingTimeController});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            // padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    // alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular((30)),
                          topRight: Radius.circular((30))),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        "Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  // PaymentFieldContainer(
                  //   hintName: 'Pay Now',
                  // ),
                  // PaymentFieldContainer(
                  //   hintName: 'Method',
                  // ),
                  // CustomeDropDownButton(),
                  PaymentTimeDropDown(),
                  PaymentMethodDropDown(),
                  PaymentTypeDropDown(),
                  // PaymentFieldContainer(
                  //   hintName: 'Type  of Wallet',
                  // ),
                  PaymentFieldContainer(
                    hintName: 'Transaction Id',
                  ),
                  PaymentFieldContainer(
                    hintName: 'Paid Amount',
                  ),
                  PaymentFieldContainer(
                    hintName: 'Remaining Amount',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
