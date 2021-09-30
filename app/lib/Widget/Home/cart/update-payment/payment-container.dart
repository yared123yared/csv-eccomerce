import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment-filed-container.dart';
import 'payment-method-dropdown.dart';
import 'payment-time-payment-dropdown.dart';
import 'payment-type-wallet.dart';

class PaymentValues {
  double Remaining;
  PaymentValues({
    required this.Remaining,
  });
}

class UpdatePaymentContainer extends StatelessWidget {
  // final TextEditingController payingTimeController;
  // PaymentContainer({required this.payingTimeController});
  final Function onAddPaidPressed;
  final Key formKey;
  // final PaymentValues paymentValues;

  UpdatePaymentContainer({
    required this.onAddPaidPressed,
    required this.formKey,
    // required this.paymentValues,
  });
  // final _formKey = GlobalKey<FormState>();
  // late OrdersBloc orBloc;

  @override
  Widget build(BuildContext context) {
    // orBloc = BlocProvider.of<OrdersBloc>(context);
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          // padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
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
                      cubit.tPayment(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    // textAlign: TextAlign.left,
                  ),
                ),
                // ),
                UpdatePaymentTimeDropDown(),
                BlocBuilder<OrdersBloc, OrdersState>(
                  builder: (context, state) {
                    if (state.request.paymentWhen == 'later') {
                      print("pay--later");
                      return Container();
                    } else {
                      print("pay--now");

                      return Column(
                        children: [
                          UpdatePaymentMethodDropDown(),
                          Visibility(
                            visible: state.request.paymentMethod == "Cash"
                                ? false
                                : true,
                            child: Column(
                              children: [
                                UpdatePaymentTypeDropDown(),
                                // UpdatePaymentFieldContainer(
                                //     paid: false,
                                //     initialValue:
                                //         state.request.transactionId.toString(),
                                //     hintName: 'Transaction Id',
                                //     readOnly: false,
                                //     onChanged: this.addTansactionId),
                              ],
                            ),
                          ),
                          BlocBuilder<OrdersBloc, OrdersState>(
                            builder: (context, state) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: TextFormField(
                                  // controller: this.controller,
                                  initialValue:
                                      state.request.amountPaid.toString(),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (val) =>
                                      this.onAddPaidPressed(val),
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                  decoration: new InputDecoration(
                                    labelText: 'Paid Amount',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    print(
                                        "State of the credit: ${state.credit}");
                                    if (val!.length == 0) {
                                      return "This field is required";
                                    } else if (state.credit! <
                                        double.parse(val)) {
                                      return "Credit Limit Exceed";
                                    } else if (state.request.total! <
                                        double.parse(val)) {
                                      return "Value greater than the total value";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  // void addTansactionId(String value) {
  //   ordersB.add(AddTransactionIdEvent(transactionId: value));
  // }

//   void addPaidAmount(String value) async {
//     // if (value != "")
//     //   ordersBloc.add(AddPaidAmountEvent(amount: int.parse(value)));
//     this.onAddPaidPressed(value);
//   }

//   void addRemainingAmount(String value) {
//     if (value != "")
//       orBloc.add(AddRemainingAmountEvent(amount: int.parse(value)));
//   }
// }
}
