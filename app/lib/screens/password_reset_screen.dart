import 'package:app/Widget/login/email_textfield.dart';
import 'package:app/Widget/passowrd-reset/description_text.dart';

import 'package:app/Widget/passowrd-reset/forgot_password.dart';
import 'package:app/Widget/passowrd-reset/next_button.dart';

import 'package:app/Widget/passowrd-reset/welcome.dart';

import 'package:flutter/material.dart';

class PasswordReset extends StatelessWidget {
  static String routeName = "/passowrd-reset";
  TextEditingController emailController = TextEditingController();
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
            ForgotPassowrdText(),
            SizedBox(
              height: height * 0.06,
            ),
            DescriptionText(),
            SizedBox(
              height: height * 0.06,
            ),
            EmailTextField(EmailEditingController: emailController,),
            SizedBox(
              height: height * 0.06,
            ),
            NextButton(),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
