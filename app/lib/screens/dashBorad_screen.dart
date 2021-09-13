import 'package:app/Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Blocs/dashBoard/numbers/bloc/number_dashboard_bloc.dart';
import 'package:app/Widget/dashboard/daily_debt.dart';
import 'package:app/Widget/dashboard/recent_total_container.dart';
import 'package:app/Widget/dashboard/monthly_debt.dart';
import 'package:app/Widget/dashboard/search_container.dart';
import 'package:app/Widget/dashboard/title_containers.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/dashBoardScreen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // final keyRefresh = GlobalKey<RefreshIndicatorState>();

  late NumberDashboardBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<NumberDashboardBloc>(context);
    bloc.add(FeatchNumberDashevent());

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is LoginSuccessState) {
                    return Column(
                      children: [
                        TitleContainers(
                          text: "CREDIT LIMIT",
                          number:
                              '${state.user.user?.credit ?? "Unknown"}',
                          image: "assets/images/debit-card.png",
                          color: redDashBoard,
                          imagebackgroundcolor: Color(0xFFee3a3b),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleContainers(
                          text: "CREDIT START AT",
                          number:
                              '${state.user.user?.creditLimitStartDate ?? "Unknown"}',
                          image: "assets/images/calendar-icon.png",
                          color: orangDashBoard,
                          imagebackgroundcolor: Color(0xFFf2a24e),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleContainers(
                          text: "CREDIT END AT",
                          number:'${state.user.user?.creditLimitEndDate ?? "Unknown"}',
                          image: "assets/images/calendar-icon.png",
                          color: purpleDashBoard,
                          imagebackgroundcolor: Color(0xFFaa4cec),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 15,
              ),
              BlocBuilder<NumberDashboardBloc, NumberDashboardState>(
                builder: (context, state) {
                  if (state is NumberDashboardInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NumberDashLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NumberDashSuccessState) {
                    return Column(
                      children: [
                        TitleContainers(
                          text: "Clients",
                          number: '${state.numberdash.clientsCount}',
                          image: "assets/images/value.png",
                          color: redDashBoard,
                          imagebackgroundcolor: Color(0xFFee3a3b),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleContainers(
                          text: "Total Debts",
                          number: "\$ ${state.numberdash.totalDebt}",
                          image: "assets/images/graph.png",
                          color: orangDashBoard,
                          imagebackgroundcolor: Color(0xFFf2a24e),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleContainers(
                          text: "Total Payments",
                          number: "\$ ${state.numberdash.totalPayment}",
                          image: "assets/images/debit-card.png",
                          color: purpleDashBoard,
                          imagebackgroundcolor: Color(0xFFaa4cec),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                "Recent Orders",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SearchCDashBoard(),
              SizedBox(
                height: 20,
              ),
              InfoTotalContainer(),
              SizedBox(
                height: 20,
              ),
              DailyDebt(),
              SizedBox(
                height: 20,
              ),
              ManthlyDebt(),
            ],
          ),
        ),
      ),
    );
  }
}
