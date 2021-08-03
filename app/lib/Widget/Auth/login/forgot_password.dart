import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class ResetPasswordOption extends StatelessWidget {
  final Function onPressed;
  ResetPasswordOption({
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return InkWell(
      onTap: () => this.onPressed,
      child: Text(
        'Forgot Passowrd?',
        // textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: loginSize.getFontSize2,
            color: Colors.black),
      ),
    );
  }
}
