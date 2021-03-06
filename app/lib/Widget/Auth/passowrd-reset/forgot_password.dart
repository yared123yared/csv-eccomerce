import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class ForgotPassowrdText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Center(
      child: Text(
        'Forgot Password',
        // textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}
