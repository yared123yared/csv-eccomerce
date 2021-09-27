import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/client.dart';
import 'package:app/models/client.dart';
import 'package:app/Widget/Orders/allOrders/Pdf/pdf_screen.dart';

import 'package:app/models/navigation/navigation.dart';
// import 'package:app/screens/client_new_screen.dart';
import 'package:app/models/client.dart' as Client;
import 'package:app/models/login_info.dart';
import 'package:app/models/navigation/navigation.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/route_args.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/screens/cart_screens/add_client.dart';
import 'package:app/screens/cart_screens/cart_screen.dart';
import 'package:app/screens/cart_screens/update_order_screen.dart';
import 'package:app/screens/client_detail_screen.dart';
import 'package:app/screens/client_edit_screen.dart';
import 'package:app/screens/client_profile.dart';
import 'package:app/screens/clients_screen.dart';
import 'package:app/screens/dashBorad_screen.dart';
import 'package:app/screens/invoice-client-search-screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/orders_screen/all_orders_screen.dart';
import 'package:app/screens/orders_screen/allorder_details_screen.dart';
import 'package:app/screens/orders_screen/ordersb_byDebt_screen.dart';
import 'package:app/screens/payments/payments_screen.dart';
import 'package:app/screens/reports_screens/collection_report.dart';
import 'package:app/screens/reports_screens/customer_by_debt_screen.dart';
import 'package:app/screens/reports_screens/salesReport_screen.dart';
import 'package:app/screens/product_detail_screen.dart';
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
              print("auto loging");
              return SplashScreen(title: 'Authenticating');
            } else if (state is AutoLoginSuccessState) {
              isAuthenticated = true;
              // print("Login success state with user ${state.user}");
              print("auto login success");
              return MainScreen(
                checkValue: 1,
              );
            } else if (state is AutoLoginFailedState) {
              print("auto login failed");
              isAuthenticated = false;
              return Login();
            } else if (state is LoginSuccessState) {
              print("login success");
              isAuthenticated = false;
              return MainScreen(
                checkValue: 1,
              );
            }
            return Login();
          },
        ),
      );
    } else if (settings.name == MainScreen.routeName) {
      int check = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => MainScreen(
                checkValue: check,
                // user: settings.arguments as LoggedUserInfo,
              ));
    } else if (settings.name == SendOtpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SendOtpScreen());
    } else if (settings.name == ProductDetail.routeName) {
      List data = settings.arguments as List<Object>;
      Data product = data[0] as Data;
      print(
          "++++___Attribute on the route::::${product.selectedAttributes!.map((e) => e.pivot!.id)}");
      VoidCallback onClicked = data[1] as VoidCallback;

      return MaterialPageRoute(
          builder: (context) => ProductDetail(
                products: product,
                onClicked: onClicked,
              ));
      // return MaterialPageRoute(builder: (context) => ProductDetail());
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
    } else if (settings.name == ClientDetailScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => ClientDetailScreen(
          client: settings.arguments as Client.Client,
        ),
      );
    } else if (settings.name == ClientEditScreen.routeName) {
      if (settings.arguments != null) {
        // print("--route ----${settings.arguments}");
        return MaterialPageRoute(
            builder: (context) => ClientEditScreen(
                  args: settings.arguments as ClientEditArgs,
                ));
      }
      return MaterialPageRoute(builder: (context) => ClientEditScreen(
                  args: settings.arguments as ClientEditArgs,
      ));
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
    } else if (settings.name == UpdateOrder.routeName) {
      return MaterialPageRoute(
          builder: (context) => UpdateOrder(
                order: settings.arguments as DataAllOrders,
              ));
    } else if (settings.name == AddClient.routeName) {
      return MaterialPageRoute(
        builder: (context) => AddClient(),
      );
    } else if (settings.name == CustomerByDebtScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => CustomerByDebtScreen(),
      );
    } else if (settings.name == AllOrdersScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => AllOrdersScreen(),
      );
    } else if (settings.name == OrdersByDebtScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => OrdersByDebtScreen(),
      );
    } else if (settings.name == PaymentsScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => PaymentsScreen(),
      );
    } else if (settings.name == DashBoardScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => DashBoardScreen(),
      );
    } else if (settings.name == PdafScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => PdafScreen(0),
      );
    } else if (settings.name == InvoiceClientSearch.routeName) {
      return MaterialPageRoute(builder: (context) => InvoiceClientSearch());
    } else if (settings.name == AllOrderDetailsScreen.routeName) {
      int id = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => AllOrderDetailsScreen(id));
    }
    print("unknown route");
    return MaterialPageRoute(builder: (context) => Login());
  }
}
