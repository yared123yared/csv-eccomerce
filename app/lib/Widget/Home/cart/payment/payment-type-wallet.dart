import 'package:app/Widget/Home/cart/payment/payment-custome-dropdown.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:flutter/material.dart';

class PaymentTypeDropDown extends StatefulWidget {
  // final TextEditingController payingTimeController;
  // PaymentTypeDropDown({required this.payingTimeController});
  @override
  _PaymentTypeDropDownState createState() => _PaymentTypeDropDownState();
}

class _PaymentTypeDropDownState extends State<PaymentTypeDropDown> {
  String value = 'Smilepay';
  @override
  Widget build(BuildContext context) {
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
      value: this.value,
    );
  }

  void onChanged(String? value) {
    setState(() {
      value = value!;
      // print(widget.dropDownItems[_value].chil);
    });
  }
}
