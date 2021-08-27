import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class PaymentCustomTextField extends StatelessWidget {
  final String? textFieldName;
  final TextEditingController? controller;
  final Function? validator;
  final bool? obsecureText;
  final bool? isRequired;
  final String? initialValue;
  final Function? onChanged;
  PaymentCustomTextField({
    this.textFieldName,
    this.controller,
    this.validator,
    this.obsecureText,
    this.isRequired,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Material(
      color: Colors.white,
      elevation: 1.0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      textStyle: TextStyle(color: Colors.black),
      child: Container(
        width: loginSize.getTextFieldWidth,
        child: TextFormField(
          controller: this.controller,
          // obscureText: this.obsecureText,
          // initialValue: this.initialValue,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (value) => this.onChanged!(value.toString()),
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          style: TextStyle(fontSize: 18, color: Colors.grey),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 6,
              bottom: 6,
              left: 12,
            ),
            border: InputBorder.none,

            hintText: '${this.textFieldName}',
            errorStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
            ),
            errorMaxLines: 1,
            // hintText: "${this.textFieldName}",
          ),
          // validator: (value) => validator!(value),
        ),
      ),
    );
  }
}
