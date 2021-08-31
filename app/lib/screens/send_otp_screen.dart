import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Widget/Auth/auth-export.dart';
import 'package:app/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendOtpScreen extends StatefulWidget {
  static String routeName = "/send-otp";

  @override
  _SendOtpScreenState createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  void sendOtpHandler() {
    print("send otp --invoked from send otp screen");
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    SendOTPEvent sendOtpEvent = new SendOTPEvent(
      email: emailController.text.toString(),
    );
    BlocProvider.of<AuthBloc>(context, listen: false).add(sendOtpEvent);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    double fontSize1 = height * 0.04;

    return Material(
      child: Container(
        color: Theme.of(context).accentColor.withOpacity(0.8),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SendingOtpSuccessState) {
              Navigator.of(context).pushNamed(ResetPasswordScreen.routeName,
                  arguments: emailController.text.toString());
            }
          },
          builder: (context, state) {
            Widget label;
            if (state is SendingOtpFailedState) {
              label = Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    state.message,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else if (state is SendingOtpState) {
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
                      ForgotPassowrdText(),
                      label,
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: DescriptionText(
                          text: 'Provide your account email for which',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: DescriptionText(
                          text: 'you want to reset your password',
                        ),
                      ),
                      //
                      SizedBox(
                        height: height * 0.06,
                      ),
                      CustomTextField(
                        textFieldName: 'Email Address',
                        controller: emailController,
                        icon: Icons.person,
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

                      // EmailTextField(EmailEditingController: emailController,),
                      SizedBox(
                        height: height * 0.06,
                      ),

                      NextButton(
                        onPressed: sendOtpHandler,
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
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
