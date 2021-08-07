import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/category_screen.dart';
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
            return isAuthenticated ? CategoryScreen() : Login();
          },
        ),
      );
    } else if (settings.name == MainScreen.routeName) {
      return MaterialPageRoute(builder: (context) => MainScreen());
    }

    return MaterialPageRoute(builder: (context) => Login());
  }
}
