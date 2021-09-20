import 'package:app/constants/login/size.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/screens/send_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(SendOtpScreen.routeName);
      },
      child: Text(
        cubit.tForgotPassword(),
        // textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: loginSize.getFontSize2,
            color: Colors.black),
      ),
    );
  }
}
