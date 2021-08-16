import 'package:app/models/navigation/navigation.dart';
import 'package:app/screens/client_new_screen.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/reports_screens/collection_report.dart';
import 'package:app/screens/reports_screens/customer_by_debt_screen.dart';
import 'package:app/screens/reports_screens/salesReport_screen.dart';
import 'package:app/screens/reset_password_screen.dart';
import 'package:app/screens/send_otp_screen.dart';
import 'package:app/screens/verify-otp-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              print("Login success state with user ${state.user}");
              return MainScreen();
            } else if (state is AutoLoginFailedState) {
              isAuthenticated = false;
              return Login();
            }
            return Login();
          },
        ),
      );
    } else if (settings.name == MainScreen.routeName) {
      return MaterialPageRoute(
          builder: (context) => MainScreen(
              // user: settings.arguments as LoggedUserInfo,
              ));
    } else if (settings.name == SendOtpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SendOtpScreen());
    } else if (settings.name == ClientProfile.routeName) {
      return MaterialPageRoute(
          builder: (context) => ClientProfile(
              // user: settings.arguments as LoggedUserInfo,
              ));
    } else if (settings.name == ClientsScreen.routeName) {
      return MaterialPageRoute(
          builder: (context) => ClientsScreen(
              // scaffoldKey: settings.arguments as GlobalKey<ScaffoldState>,
              // user: settings.arguments as LoggedUserInfo,
              ));
    } else if (settings.name == NewClientScreen.routeName) {
      return MaterialPageRoute(builder: (context) => NewClientScreen());
    } else if (settings.name == ResetPasswordScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(
          email: settings.arguments.toString(),
        ),
      );
    } else if (settings.name == VerifyOtpScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => VerifyOtpScreen(
          otpScreenData: settings.arguments as OtpScreenData,
        ),
      );
    } else if (settings.name == SalesReportScreens.routeName) {
      return MaterialPageRoute(
        builder: (context) => SalesReportScreens(),
      );
    } else if (settings.name == CollectionReportScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => CollectionReportScreen(),
      );
    } else if (settings.name == CustomerByDebtScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => CustomerByDebtScreen(),
      );
    }
    return MaterialPageRoute(builder: (context) => Login());
  }
}
