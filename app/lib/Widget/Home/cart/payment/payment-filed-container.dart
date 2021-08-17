import 'package:app/Widget/Home/cart/payment/payment-custome-textfield.dart';

import 'package:flutter/material.dart';

class PaymentFieldContainer extends StatelessWidget {
  final String hintName;
  PaymentFieldContainer({required this.hintName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PaymentCustomTextField(
            textFieldName: '${this.hintName}',
            // initialValue: values['first_name'],
            // controller: firstNameController,
            // validator: (value) => LengthValidator(value, 1),
            obsecureText: false,
            isRequired: true,
          ),
        ],
      ),
    );
  }
}
