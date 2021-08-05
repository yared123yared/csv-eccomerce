import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class CustomFileButton extends StatelessWidget {
  // final TextEditingController controller;
  // final bool isRequired;
  final String title;
  CustomFileButton({
    required this.title,
    // required this.controller,
    // required this.isRequired,
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
      child: GestureDetector(
        child: Container(
          width: loginSize.getTextFieldWidth,
          child: Row(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: '${this.title}', helperText: '${this.title}'),
                enabled: false,
                // controller: this.controller,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 50,
                color: Color(0xFFF2F6F9),
                child: Text('Browse'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
