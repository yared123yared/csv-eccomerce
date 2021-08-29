import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentTypeDropDown extends StatefulWidget {
  // final TextEditingController payingTimeController;
  // PaymentTypeDropDown({required this.payingTimeController});
  @override
  _PaymentTypeDropDownState createState() => _PaymentTypeDropDownState();
}

class _PaymentTypeDropDownState extends State<PaymentTypeDropDown> {
  String value = 'Smilepay';
  late OrdersBloc ordersBloc;
  @override
  Widget build(BuildContext context) {
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return CustomeDropDownButton(
          dropDownItems: [
            DropdownMenuItem(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Text(
                    "Smilepay",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              value: "Smilepay",
            ),
            DropdownMenuItem(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Text(
                    "Orange pay",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              value: "Orange pay",
            ),
          ],
          onChanged: this.onChanged,
          value: state.request.typeOfWallet as String,
        );
      },
    );
  }

  void onChanged(String? value) {
    print("payment time on changed method");
    setState(() {
      value = value;
      // print(widget.dropDownItems[_value].chil);
    });

    ordersBloc.add(AddPaymentTypeEvent(type: value as String));
    BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
        print("Updated state ${state.request}");
      },
      child: Container(),
    );
  }
}
