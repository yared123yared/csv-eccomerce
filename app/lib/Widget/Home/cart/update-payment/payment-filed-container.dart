
import 'package:flutter/material.dart';

import 'payment-custome-textfield.dart';
import 'payment-customer-textfiled-paid-amount.dart';

class UpdatePaymentFieldContainer extends StatelessWidget {
  final String hintName;
  final Function onChanged;
   String? initialValue;
  final bool readOnly;
  final bool paid;
  TextEditingController? controller;
  UpdatePaymentFieldContainer({
    required this.hintName,
    required this.onChanged,
    required this.readOnly,
    required this.paid,
     this.initialValue,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          this.paid == true
              ? UpdatePaymentCustomTextFieldPaidAmount(
                  textFieldName: '${this.hintName}',
                  initialValue: this.initialValue,
                  controller: controller,
                  // validator: (value) => LengthValidator(value, 1),
                  onChanged: this.onChanged,
                  obsecureText: false,
                  isRequired: true,
                )
              : UpdatePaymentCustomTextField(
                  textFieldName: '${this.hintName}',
                  initialValue: this.initialValue,
                  controller: controller,
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
