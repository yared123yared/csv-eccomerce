import 'package:app/Blocs/cart/bloc/payment/bloc/payment_bloc.dart';
import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodDropDown extends StatefulWidget {
  // final TextEditingController payingTimeController;
  // PaymentMethodDropDown({required this.payingTimeController});
  @override
  _PaymentMethodDropDownState createState() => _PaymentMethodDropDownState();
}

class _PaymentMethodDropDownState extends State<PaymentMethodDropDown> {
  String value = 'Wallet';
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
                "Wallet",
                textAlign: TextAlign.start,
              ),
            ),
          ),
          value: "Wallet",
        ),
        DropdownMenuItem(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: Text(
                "Cash",
                textAlign: TextAlign.start,
              ),
            ),
          ),
          value: "Cash",
        ),
      ],
      onChanged: this.onChanged,
      value: this.value,
    );
  }

  void onChanged(String? value) {
    print("payment method on changed method");
    setState(() {
      value = value;
      // print(widget.dropDownItems[_value].chil);
    });

    paymentBloc.add(AddPaymentMethodEvent(method: value as String));
    BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        // TODO: implement listener
        print("Updated state ${state.payment}");
      },
      child: Container(),
    );
  }
}
