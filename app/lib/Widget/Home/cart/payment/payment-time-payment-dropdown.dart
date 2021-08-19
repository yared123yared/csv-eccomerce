import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:flutter/material.dart';

class PaymentTimeDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomeDropDownButton(dropDownItems: [
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
        value: 1,
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
        value: 2,
      ),
    ]);
  }
}
