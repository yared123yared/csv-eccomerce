import 'package:app/constants/login/size.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PaymentCustomTextField extends StatelessWidget {
  final String? textFieldName;
  final TextEditingController? controller;
  final Function? validator;
  final bool? obsecureText;
  final bool? isRequired;
  final String? initialValue;
  final Function? onChanged;
  final bool readonly;
  PaymentCustomTextField({
    this.textFieldName,
    this.controller,
    this.validator,
    this.obsecureText,
    this.isRequired,
    this.initialValue,
    this.onChanged,
    required this.readonly,
  });

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Container(
      width: loginSize.getTextFieldWidth,
      child: TextFormField(
        readOnly: readonly,
        controller: this.controller,
        // obscureText: this.obsecureText,
        initialValue: this.initialValue,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'This field is required';
        //   }
        //   return null;
        // },
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: (value) => this.onChanged!(value.toString()),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        style: TextStyle(fontSize: 18, color: Colors.grey),
        decoration: new InputDecoration(
          labelText: this.textFieldName,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        validator: (val) {
          if (val!.length == 0) {
            return "This field is required";
          } else {
            return null;
          }
        },
        // keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
