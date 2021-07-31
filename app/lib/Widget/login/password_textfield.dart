import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mypasswordController = TextEditingController();
    return CustomTextField(
        textFieldName: "Enter Passowrd", controller: _mypasswordController);
  }
}
