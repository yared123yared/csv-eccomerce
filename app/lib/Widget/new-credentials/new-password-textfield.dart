import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class NewPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _myemailController = TextEditingController();
    return CustomTextField(
        textFieldName: "New Password",
        controller: _myemailController,
        icon: Icon(
          Icons.lock,
          color: Colors.black,
        ));
  }
}
