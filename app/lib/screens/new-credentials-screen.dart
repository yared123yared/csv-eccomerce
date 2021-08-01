import 'package:app/Widget/Auth/auth-export.dart';
import 'package:flutter/material.dart';

class NewCredentialsScreen extends StatelessWidget {
  static String routeName = "/verification";

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
            NewCredentialText(),
            SizedBox(
              height: height * 0.06,
            ),
            NewPasswordTextField(),
            SizedBox(height: height * 0.01),
            ConfirmPasswordTextField(),
            SizedBox(
              height: height * 0.06,
            ),
            UpdateButton(),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
