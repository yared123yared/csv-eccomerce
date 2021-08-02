import 'package:flutter/material.dart';

import '../Common/custom_textfield.dart';

class PasswordTextField extends StatelessWidget {
  final passwordEditingController;
  PasswordTextField({this.passwordEditingController});
  @override
  Widget build(BuildContext context) {
    // final _mypasswordController = TextEditingController();
    return CustomTextField(
        textFieldName: "Enter Passowrd",
        controller: passwordEditingController,
        icon: Icons.lock,
        obsecureText: false,
        validator: (value) {
          if (value == null) {
            return "Password is empty";
          }
        });
  }
}
