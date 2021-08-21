import 'package:app/Blocs/cart/bloc/payment/bloc/payment_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:app/models/request/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentTimeDropDown extends StatefulWidget {
  // final TextEditingController payingTimeController;
  // PaymentTimeDropDown({required this.payingTimeController});
  @override
  _PaymentTimeDropDownState createState() => _PaymentTimeDropDownState();
}

class _PaymentTimeDropDownState extends State<PaymentTimeDropDown> {
  String value = 'Pay Later';
  late PaymentBloc paymentBloc;
  @override
  Widget build(BuildContext context) {
    paymentBloc = BlocProvider.of<PaymentBloc>(context);
    return CustomeDropDownButton(
      dropDownItems: [
        DropdownMenuItem(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: Text(
                "Pay Later",
                textAlign: TextAlign.start,
              ),
            ),
          ),
          value: "Pay Later",
        ),
        DropdownMenuItem(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: Text(
                "Pay Now",
                textAlign: TextAlign.start,
              ),
            ),
          ),
          value: "Pay Now",
        ),
      ],
      onChanged: this.onChanged,
      value: this.value,
    );
  }

  void onChanged(String? value) {
    print("payment time on changed method");
    setState(() {
      value = value;
      // print(widget.dropDownItems[_value].chil);
    });

    BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        print("entered to the listner");
        // TODO: implement listener
        print(state.payment);
        Payment payment = state.payment as Payment;
        payment.PaymentWhen = this.value;
        paymentBloc.add(UpdatePaymentEvent(payment: payment));
      },
      child: Container(),
    );
  }
}
