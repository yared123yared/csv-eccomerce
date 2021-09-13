import 'package:app/Widget/Home/cart/payment/payment-custome-textfield.dart';
import 'package:app/Widget/Home/cart/payment/payment-customer-textfiled-paid-amount.dart';

import 'package:flutter/material.dart';

class PaymentFieldContainer extends StatelessWidget {
  final String hintName;
  final Function onChanged;
  final String initialValue;
  final bool readOnly;
  final bool paid;
  PaymentFieldContainer(
      {required this.hintName,
      required this.onChanged,
      required this.readOnly,
      required this.paid,
      required this.initialValue});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          this.paid==true?PaymentCustomTextFieldPaidAmount(
            textFieldName: '${this.hintName}',
            initialValue: this.initialValue,
            // controller: firstNameController,
            // validator: (value) => LengthValidator(value, 1),
            onChanged: this.onChanged,
            obsecureText: false,
            isRequired: true,
          ):PaymentCustomTextField(
            textFieldName: '${this.hintName}',
            initialValue: this.initialValue,
            // controller: firstNameController,
            // validator: (value) => LengthValidator(value, 1),
            onChanged: this.onChanged,
            obsecureText: false,
            isRequired: true, readonly: readOnly,
          ),
        ],
      ),
    );
  }
}
