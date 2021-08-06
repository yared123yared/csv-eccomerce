import 'package:app/constants/login/size.dart';
import 'package:app/screens/send_otp_screen.dart';
import 'package:flutter/material.dart';

class ResetPasswordOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(SendOtpScreen.routeName);
      },
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
