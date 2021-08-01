import 'package:flutter/material.dart';

import '../Common/custom_textfield.dart';

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mypasswordController = TextEditingController();
    return CustomTextField(
      textFieldName: "Enter Passowrd",
      controller: _mypasswordController,
      icon: Icon(Icons.lock, color: Colors.black),
    );
  }
}
