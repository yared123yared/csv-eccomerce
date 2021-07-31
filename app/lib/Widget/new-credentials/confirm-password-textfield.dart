import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mypasswordController = TextEditingController();
    return CustomTextField(
      textFieldName: "Confirm Password",
      controller: _mypasswordController,
      icon: Icon(
        Icons.lock,
        color: Colors.black,
      ),
    );
  }
}
