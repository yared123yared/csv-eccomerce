import 'package:flutter/material.dart';

import '../Common/custom_textfield.dart';

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _myemailController = TextEditingController();
    return CustomTextField(
        textFieldName: "Enter Email",
        controller: _myemailController,
        icon: Icon(
          Icons.email,
          color: Colors.black,
        ));
  }
}
