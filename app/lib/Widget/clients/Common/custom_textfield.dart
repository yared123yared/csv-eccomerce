import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldName;
  final TextEditingController controller;
  final Function validator;
  final bool obsecureText;
  final bool isRequired;
  CustomTextField({
    required this.textFieldName,
    required this.controller,
    required this.validator,
    required this.obsecureText,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Material(
      color: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: loginSize.getTextFieldWidth,
        child: TextFormField(
          controller: this.controller,
          obscureText: this.obsecureText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 6,
              bottom: 6,
              left: 12,
            ),
            border: InputBorder.none,
            // prefixText: '${this.textFieldName}',
            prefixIcon: Row(
              children: [
                Text('  ${this.textFieldName}'),
                this.isRequired
                    ? Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : Text(''),
              ],
            ),

            //   ),

            // hintText: 'Enter ${this.textFieldName}',
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
