import 'package:app/Widget/Home/cart/payment/payment-custome-textfield.dart';

import 'package:flutter/material.dart';

class PaymentFieldContainer extends StatelessWidget {
  final String hintName;
  final Function onChanged;
  PaymentFieldContainer({required this.hintName, required this.onChanged});
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
            onChanged: this.onChanged,
            obsecureText: false,
            isRequired: true,
          ),
        ],
      ),
    );
  }
}
