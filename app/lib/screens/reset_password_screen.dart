import 'package:app/Widget/Auth/Common/welcome.dart';
import 'package:app/Widget/Auth/new-credentials/new_credential_text.dart';
import 'package:app/Widget/Auth/new-credentials/update_button.dart';
import 'package:app/Widget/login/custom_textfield.dart';
import 'package:app/models/navigation/navigation.dart';
import 'package:app/screens/verify-otp-screen.dart';

import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = "/verification";
  final String email;
  ResetPasswordScreen({required this.email});
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmedPasswordController = TextEditingController();

  void resetPasswordHandler() {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    Navigator.of(context).pushNamed(
      VerifyOtpScreen.routeName,
      arguments: OtpScreenData(
        email: widget.email,
        password: newPasswordController.text,
        confirmed_password: confirmedPasswordController.text.toString(),
      ),
    );
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    // double width = screenSize.width;
    // double fontSize1 = height * 0.04;

    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            body: SingleChildScrollView(
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
                  CustomTextField(
                    textFieldName: 'New Password',
                    controller: newPasswordController,
                    icon: Icons.lock,
                    validator: (value) {
                      if (value.isEmpty || value.toString().length < 5) {
                        return "Password Too Short";
                      } else if (value.toString() !=
                          confirmedPasswordController.text.toString()) {
                        return "Password Not Match";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: true,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                    textFieldName: 'Confirmed Password',
                    controller: confirmedPasswordController,
                    icon: Icons.lock,
                    validator: (value) {
                      if (value.isEmpty || value.toString().length < 5) {
                        return "Password Too Short";
                      } else if (value.toString() !=
                          newPasswordController.text.toString()) {
                        return "Password Not Match";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: true,
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  UpdateButton(
                    onPressed: () => resetPasswordHandler,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
