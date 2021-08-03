import 'package:app/models/navigation/navigation.dart';
import 'package:app/screens/reset_password_screen.dart';
import 'package:app/screens/verify-otp-screen.dart';
import 'package:app/screens/send_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/home_screen.dart';
import '../screens/login.dart';
import '../screens/splash_screen.dart';

import 'package:app/Blocs/auth/bloc/auth_bloc.dart';

bool isAuthenticated = false;

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AutoLoginState) {
              return SplashScreen(title: 'Authenticating');
            } else if (state is AutoLoginSuccessState) {
              isAuthenticated = true;
            } else if (state is AutoLoginFailedState) {
              isAuthenticated = false;
            }
            return isAuthenticated ? Home() : Login();
          },
        ),
      );
    }
    else if(settings.name==Home.routeName){
      return MaterialPageRoute(builder: (context) => Home());
    }
    else if (settings.name == SendOtpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SendOtpScreen());
    }
    else if (settings.name == ResetPasswordScreen.routeName) {
      return MaterialPageRoute(builder: (context) => ResetPasswordScreen(
        email: settings.arguments.toString(),
      ));
    }
    else if (settings.name == VerifyOtpScreen.routeName) {

      return MaterialPageRoute(builder: (context) => VerifyOtpScreen(
        otpScreenData: settings.arguments as OtpScreenData,
      ));

    }
    return MaterialPageRoute(builder: (context) => Login());
  }
}
