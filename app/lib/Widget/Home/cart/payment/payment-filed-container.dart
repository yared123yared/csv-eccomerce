import 'package:app/Widget/Home/cart/payment/payment-custome-textfield.dart';

import 'package:flutter/material.dart';

class PaymentFieldContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentCustomTextField(
          textFieldName: 'First Name',
          // initialValue: values['first_name'],
          // controller: firstNameController,
          // validator: (value) => LengthValidator(value, 1),
          obsecureText: false,
          isRequired: true,
        ),
      ],
    );
  }
}
