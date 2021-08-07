import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class CustomFileInput extends StatelessWidget {
  final String textFieldName;
  final TextEditingController controller;
  final bool isRequired;
  final Function onPressed;
  CustomFileInput({
    required this.textFieldName,
    required this.controller,
    required this.isRequired,
    required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return InkWell(
      onTap: this.onPressed(),
      child: Material(
        color: Colors.white,
        elevation: 1.0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          width: loginSize.getTextFieldWidth,
          child: TextFormField(
            enabled: false,
            controller: this.controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            // onEditingComplete: () => FocusScope.of(context).unfocus(),
            style: TextStyle(
              fontSize: 20,
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
              suffixIcon: Container(
                width: 130,
                color: Color(0xFFC6CBCE).withOpacity(0.8),
                child: Center(
                  child: Text(
                    'Browse',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
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
          ),
        ),
      ),
    );
  }
}
