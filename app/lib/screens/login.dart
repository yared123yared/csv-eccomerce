import 'package:app/Widget/login/email_textfield.dart';
import 'package:app/Widget/login/forgot_password.dart';
import 'package:app/Widget/login/login_button.dart';
import 'package:app/Widget/login/login_text.dart';
import 'package:app/Widget/login/password_textfield.dart';
import 'package:app/Widget/login/welcome.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    double fontSize1 = height * 0.04;

    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: [
            Welcome(),
            SizedBox(
              height: height * 0.04,
            ),
            LoginText(),
            SizedBox(
              height: height * 0.06,
            ),
            EmailTextField(),
            SizedBox(height: height * 0.01),
            PasswordTextField(),
            SizedBox(
              height: height * 0.06,
            ),
            LoginButton(),
            SizedBox(
              height: height * 0.03,
            ),
            ResetPasswordOption()
          ],
        ),
      ),
    );
  }
}
