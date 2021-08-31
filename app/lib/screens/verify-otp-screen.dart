import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Widget/Auth/Common/welcome.dart';
import 'package:app/Widget/Auth/passowrd-reset/confirm_code.dart';
import 'package:app/Widget/Auth/passowrd-reset/description_text.dart';
import 'package:app/Widget/Auth/passowrd-reset/did_not_recieve_text.dart';
import 'package:app/Widget/Auth/passowrd-reset/email_otp_sent.dart';
import 'package:app/Widget/Auth/passowrd-reset/otp_verification_text.dart';
import 'package:app/Widget/Auth/passowrd-reset/resend_text.dart';
import 'package:app/models/navigation/navigation.dart';
import 'package:app/screens/login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyOtpScreen extends StatefulWidget {
  static String routeName = "/change-password";

  final OtpScreenData otpScreenData;

  VerifyOtpScreen({
    required this.otpScreenData,
    Key? key,
  }) : super(key: key);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  var otp;
  void sendOtpHandler() {
    print("send otp --invoked from verify screen");

    ResendOTPEvent sendOtpEvent = new ResendOTPEvent(
      email: widget.otpScreenData.email,
    );
    BlocProvider.of<AuthBloc>(context, listen: false).add(sendOtpEvent);
  }

  void verifyAndUpdate() {
    print("verify --invoked from send otp screen");

    if (otp == null) {
      return;
    }
    ConfirmOTPEvent confirmEvent = new ConfirmOTPEvent(
      email: widget.otpScreenData.email,
      confirmed_password: widget.otpScreenData.confirmed_password,
      password: widget.otpScreenData.password,
      otp: otp,
    );
    BlocProvider.of<AuthBloc>(context, listen: false).add(confirmEvent);
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
            if (state is ConfirmOTPSuccessState) {
              print("-------verify otp screen---1");
              Navigator.of(context).pushNamed(Login.routeName);
            }
          },
          builder: (context, state) {
            Widget label;
            if (state is ResendingOtpFailedState) {
              print("-------verify otp screen---2");

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
            } else if (state is ConfirmOTPFailedState) {
              print("-------verify otp screen---3");

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
            } else if (state is ResendingOtpState ||
                state is ConfirmingOTPState) {
              print("-------verify otp screen---4");

              label = Center(
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (state is ResendingOtpSuccessState) {
              // Navigator.of(context).pushNamed(VerifyOtpScreen.routeName,
              //     arguments: emailController.text.toString());
              print("-------verify otp screen---5");

              label = Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'OTP Sent Successfully',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              label = SizedBox();
            }
            return Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Welcome(),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    OtpVerificationText(),
                    label,
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DescriptionText(
                            text: 'Enter the OTP sent to',
                          ),
                          AutoSizeText(
                            widget.otpScreenData.email,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // fontFamily: 'Raleway',
                              color: Theme.of(context).primaryColor,
                            ),
                            maxLines: 2,
                          ),
                          // EmailOtpSentText(text: widget.otpScreenData.email)
                        ],
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
                      height: height * 0.05,
                    ),
                    Center(
                      child: OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width * 0.60,
                        fieldWidth: 40,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                          otp = pin;
                        },
                        onChanged: (pin) {
                          print("changing: " + pin);
                          otp = pin;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    // EmailTextField(EmailEditingController: emailController,),
                    ConfirmCode(
                      onPressed: verifyAndUpdate,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    DidnotRecieveText(
                      text: 'Did\'t Recieve the OTP',
                    ),
                    ResendText(
                      text: 'Resend Code',
                      onTap: sendOtpHandler,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
