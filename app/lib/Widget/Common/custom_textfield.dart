import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldName;
  final TextEditingController controller;
  final Function validator;
  final bool obsecureText;

  CustomTextField({
    required this.textFieldName,
    required this.controller,
    required this.validator,
    required this.obsecureText,
  });


  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Material(
      color: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        width: loginSize.getTextFieldWidth,
        child: TextFormField(
          controller: this.controller,
          obscureText: this.obsecureText,
          keyboardType: TextInputType.text,

          textInputAction: TextInputAction.done,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 14),
            border: InputBorder.none,
            hintText: 'Enter ${this.textFieldName}',
            focusColor: Colors.black,

            errorStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,

            ),
            errorMaxLines: 1,

          ),
          validator: (value) => validator(value),
        ),
      ),
    );
  }
}
