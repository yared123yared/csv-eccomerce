import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/users.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment-custome-dropdown.dart';
import 'payment-filed-container.dart';
import 'payment-method-dropdown.dart';
import 'payment-time-payment-dropdown.dart';
import 'payment-type-wallet.dart';

class PaymentContainer extends StatelessWidget {
  // final TextEditingController payingTimeController;
  // PaymentContainer({required this.payingTimeController});
  late OrdersBloc ordersBloc;
  final Function onStateChange;
  final Key formKey;
  PaymentContainer({required this.onStateChange, required this.formKey});
  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ordersBloc = BlocProvider.of<OrdersBloc>(context);

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
                    height: MediaQuery.of(context).size.height * 0.06,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular((30)),
                          topRight: Radius.circular((30))),
                      color: Theme.of(context).primaryColor,
                      // color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        "Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  PaymentTimeDropDown(),
                  BlocBuilder<OrdersBloc, OrdersState>(
                    builder: (context, state) {
                      if (state.request.paymentWhen == 'Pay Later') {
                        print("pay--later");
                        return Container();
                      } else {
                        print("pay--now");

                        return Column(children: [
                          PaymentMethodDropDown(),
                          Visibility(
                            visible: state.request.paymentMethod == "Cash"
                                ? false
                                : true,
                            child: Column(children: [
                              PaymentTypeDropDown(),
                              PaymentFieldContainer(
                                  paid: false,
                                  initialValue:
                                      state.request.transactionId.toString(),
                                  hintName: 'Transaction Id',
                                  readOnly: false,
                                  onChanged: this.addTansactionId),
                            ]),
                          ),
                          PaymentFieldContainer(
                            paid: true,
                            initialValue: state.request.amountPaid.toString(),
                            hintName: 'Paid Amount',
                            readOnly: false,
                            onChanged: this.addPaidAmount,
                          ),
                          // if(state is RequestUpdateSuccess){
                          //   return Container();
                          // },
                          PaymentFieldContainer(
                            paid: false,
                            initialValue:
                                state.request.amountRemaining.toString(),
                            
                            hintName: 'Remaining Amount',
                            readOnly: true,
                            onChanged: this.addRemainingAmount,
                          ),
                        ]);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  void addTansactionId(String value) {
    ordersBloc.add(AddTransactionIdEvent(transactionId: value));
  }

  void addPaidAmount(String value) async {
    if (value != "")
      ordersBloc.add(AddPaidAmountEvent(amount: int.parse(value)));
  }

  void addRemainingAmount(String value) {
    if (value != "")
      ordersBloc.add(AddRemainingAmountEvent(amount: int.parse(value)));
  }
}
