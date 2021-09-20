import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/Blocs/reports/CollectionReport_cubit/bloc/collection_bloc.dart';
import 'package:app/Blocs/reports/CustomerDebt/bloc/custom_debt_bloc.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/bloc/sales_report_bloc.dart';
import 'package:app/Widget/Auth/Common/welcome.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';

import 'package:app/models/login_info.dart';
import 'package:app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Widget/login/custom_textfield.dart';
import 'package:app/Widget/Auth/login/forgot_password.dart';
import 'package:app/Widget/Auth/login/login_button.dart';
import 'package:app/Widget/Auth/login/login_text.dart';
import '../Blocs/auth/bloc/auth_bloc.dart';
import 'send_otp_screen.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  void forgotPasswordHandler(BuildContext context) {
    Navigator.of(context).pushNamed(SendOtpScreen.routeName);
  }

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

  void callFetchEvents() {
    FetchClientsEvent fetchClientsEvent = new FetchClientsEvent(loadMore: true);
    BlocProvider.of<ClientsBloc>(context, listen: false).add(fetchClientsEvent);

    FeatchCustomDebtEvent fetchCustomDebtEvent = new FeatchCustomDebtEvent();
    BlocProvider.of<CustomDebtBloc>(context, listen: false)
        .add(fetchCustomDebtEvent);

    FeatchCollectionEvent fetchCollectionEvent = new FeatchCollectionEvent();
    BlocProvider.of<CollectionBloc>(context, listen: false)
        .add(fetchCollectionEvent);

    FeatchSalesReportEvent featchSalesReportEvent =
        new FeatchSalesReportEvent();
    BlocProvider.of<SalesReportBloc>(context, listen: false)
        .add(featchSalesReportEvent);

    FeatcAllorderrEvent fetchAllordersEvent = new FeatcAllorderrEvent();
    BlocProvider.of<AllorderrBloc>(context, listen: false)
        .add(fetchAllordersEvent);
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
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              callFetchEvents();
              Navigator.of(context)
                  .pushReplacementNamed(MainScreen.routeName, arguments: 1);
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
                backgroundColor: Theme.of(context).accentColor,
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
                        textFieldName: cubit.tEmail(),
                        controller: emailController,
                        icon: Icons.email,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            return cubit.tEnterCorrectEmail();
                          } else {
                            return null;
                          }
                        },
                        obsecureText: false,
                      ),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        textFieldName: cubit.tPassword(),
                        controller: passwordController,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value.isEmpty || value.toString().length < 5) {
                            return cubit.tPasswordTooShort();
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
                      ResetPasswordOption(
                          // onPressed: () => forgotPasswordHandler(context),
                          )
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
