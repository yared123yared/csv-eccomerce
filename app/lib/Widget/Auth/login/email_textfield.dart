import 'package:flutter/material.dart';

import '../Common/custom_textfield.dart';

class EmailTextField extends StatelessWidget {
  late final EmailEditingController;

  EmailTextField({required this.EmailEditingController});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        textFieldName: "Enter Email",
        controller: this.EmailEditingController,
        icon: Icons.email,
        obsecureText: false,
        validator: (value) {
          if (value == null) {
            return "Email is empty";
          }
        });
  }
}
