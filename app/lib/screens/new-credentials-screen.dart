<<<<<<< HEAD
import 'package:app/Widget/login/custom_textfield.dart';
import 'package:app/Widget/login/welcome.dart';
import 'package:app/Widget/new-credentials/confirm-password-textfield.dart';
import 'package:app/Widget/new-credentials/new-password-textfield.dart';
import 'package:app/Widget/new-credentials/new_credential_text.dart';
import 'package:app/Widget/new-credentials/update_button.dart';
import '../Blocs/auth/bloc/auth_bloc.dart';

=======
import 'package:app/Widget/Auth/auth-export.dart';
>>>>>>> 64d86357796780782e031da3ea8f1b019771ae81
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class NewCredentialsScreen extends StatefulWidget {
  static String routeName = "/verification";

  @override
  _NewCredentialsScreenState createState() => _NewCredentialsScreenState();
}

class _NewCredentialsScreenState extends State<NewCredentialsScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmedPasswordController = TextEditingController();

  void updateHandler() {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    UpdatePasswordEvent updateEvent = new UpdatePasswordEvent(
      password: newPasswordController.text.toString(),
      confirmedPassword: confirmedPasswordController.text.toString(),
    );
    BlocProvider.of<AuthBloc>(context).add(updateEvent);
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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UpdatingPasswordSuccessState) {
              Navigator.of(context).pushReplacementNamed(Home.routeName);
            }
          },
          builder: (context, state) {
            Widget label;
            if (state is LoginFailedState) {
              label = Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Failed to Update Password',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else if (state is LoggingState) {
              label = Center(
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else {
              label = SizedBox();
            }
            return Form(
              child: Column(
                children: [
                  Welcome(),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  NewCredentialText(),
                  label,
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
                      } else if (value != confirmedPasswordController.value) {
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
                      } else if (value != newPasswordController.value) {
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
                    onPressed: updateHandler,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
