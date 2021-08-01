import 'package:app/models/login_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Widget/login/email_textfield.dart';
import 'package:app/Widget/login/forgot_password.dart';
import 'package:app/Widget/login/login_button.dart';
import 'package:app/Widget/login/login_text.dart';
import 'package:app/Widget/login/password_textfield.dart';
import 'package:app/Widget/login/welcome.dart';
import 'package:app/screens/home_screen.dart';
import '../Blocs/auth/bloc/auth_bloc.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void loginHandler() {
    if (emailController.text.isEmpty) {
      return;
    }
    if (passwordController.text.isEmpty) {
      return;
    }
    late String email=emailController.text.toString();
    late LoginInfo info = new LoginInfo(
       email,
       passwordController.text.toString(),
    );
    print(info.email);
    print(info.password);
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

            return Column(
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
                EmailTextField(
                  EmailEditingController: emailController,
                ),
                SizedBox(height: height * 0.01),
                PasswordTextField(
                  passwordEditingController: passwordController,
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
                ResetPasswordOption()
              ],
            );
          },
        ),
      ),
    );
  }
}
