import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
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
  String value = 'later';
  late OrdersBloc ordersBloc;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
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
                    cubit.tPayLater(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              value: "later",
            ),
            DropdownMenuItem(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Text(
                    cubit.tPayNow(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              value: "now",
            ),
          ],
          onChanged: this.onChanged,
          value: state.request.paymentWhen as String,
        );
      },
    );
  }

  void onChanged(String? value) {
    print("payment time on changed method");
    print(value);
    setState(() {
      value = value;
      // print(widget.dropDownItems[_value].chil);
    });

    ordersBloc.add(AddPaymentWhenEvent(when: value as String));
    BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
        print("Updated state ${state.request}");
      },
      child: Container(),
    );
  }
}
