import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class NewCredentialText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Center(
      child: Text(
        'New Credentials',
        // textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: loginSize.getFontSize1,
            color: Colors.black),
      ),
    );
  }
}
