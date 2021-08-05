import 'package:app/Widget/Auth/Common/welcome.dart';

import 'package:app/models/login_info.dart';
import 'package:app/screens/send_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Widget/login/custom_textfield.dart';
import 'package:app/Widget/Auth/login/forgot_password.dart';
import 'package:app/Widget/Auth/login/login_button.dart';
import 'package:app/Widget/Auth/login/login_text.dart';
import 'package:app/screens/home_screen.dart';
import '../Blocs/auth/bloc/auth_bloc.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void loginHandler() {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    print("-----");
    print(isValid);
    late LoginInfo info = new LoginInfo(
      emailController.text.toString(),
      passwordController.text.toString(),
    );

    LoginEvent loginEvent = new LoginEvent(user: info);
    BlocProvider.of<AuthBloc>(context).add(loginEvent);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    double fontSize1 = height * 0.04;

    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.of(context).pushReplacementNamed(
                Home.routeName,
                arguments: state.user,
              );
            }
          },
          builder: (context, state) {
            Widget label;
            if (state is LoginFailedState) {
              label = Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Failed to Authenticate',
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
              key: formKey, //key for form

              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Welcome(),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      LoginText(),
                      label,
                      SizedBox(
                        height: height * 0.06,
                      ),
                      CustomTextField(
                        textFieldName: 'Email',
                        controller: emailController,
                        icon: Icons.email,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            return "Enter Correct Email Address";
                          } else {
                            return null;
                          }
                        },
                        obsecureText: false,
                      ),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        textFieldName: 'Password',
                        controller: passwordController,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value.isEmpty || value.toString().length < 5) {
                            return "Password Too Short";
                          } else {
                            return null;
                          }
                        },
                        obsecureText: true,
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      LoginButton(
                        onPressed: () => loginHandler,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // ResetPasswordOption(
                      //   onPressed: () => Navigator.of(context)
                      //       .pushNamed(SendOtpScreen.routeName),
                      // )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void Navigate(BuildContext context) {
  print('pressed');
}
