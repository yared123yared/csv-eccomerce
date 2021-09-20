import 'package:app/constants/login/size.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Center(
      child: Text(
        cubit.tLogin(),
        // textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: loginSize.getFontSize1,
            color: Colors.black),
      ),
    );
  }
}
