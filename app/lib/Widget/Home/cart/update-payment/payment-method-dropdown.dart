import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePaymentMethodDropDown extends StatefulWidget {
  // final TextEditingController payingTimeController;
  // PaymentMethodDropDown({required this.payingTimeController});
  @override
  _UpdatePaymentMethodDropDownState createState() =>
      _UpdatePaymentMethodDropDownState();
}

class _UpdatePaymentMethodDropDownState
    extends State<UpdatePaymentMethodDropDown> {
  String value = 'Wallet';
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
                    "Wallet",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              value: "wallet",
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
              value: "cash",
            ),
          ],
          onChanged: this.onChanged,
          value: state.request.paymentMethod??"wallet",
        );
      },
    );
  }

  void onChanged(String? value) {
    print("payment method on changed method");
    setState(() {
      value = value;
      // print(widget.dropDownItems[_value].chil);
    });

    ordersBloc.add(AddPaymentMethodEvent(method: value as String));
    BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
        print("Updated state ${state.request}");
      },
      child: Container(),
    );
  }
}
