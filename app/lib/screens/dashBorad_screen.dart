import 'package:app/Blocs/credit/bloc/credit_bloc.dart';
import 'package:app/Blocs/dashBoard/numbers/bloc/number_dashboard_bloc.dart';

import 'package:app/Widget/dashboard/daily_debt.dart';
import 'package:app/Widget/dashboard/recent_total_container.dart';
import 'package:app/Widget/dashboard/monthly_debt.dart';
import 'package:app/Widget/dashboard/search_container.dart';
import 'package:app/Widget/dashboard/title_containers.dart';
import 'package:app/Widget/dashboard/title_no_symbol.dart';
import 'package:app/constants/constants.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/dashBoardScreen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late CreditBloc creditBloc;
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
    creditBloc = BlocProvider.of<CreditBloc>(context);
    creditBloc.add(CreditInitialization());
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            children: [
              BlocBuilder<CreditBloc, CreditState>(
                builder: (context, state) {
                  if (state is CreditUpdated) {
                    return Column(
                      children: [
                        TitleContainers(
                          text: cubit.tCreditLimit(),
                          number: '${state.credit}',
                          image: "assets/images/debit-card.png",
                          color: Color(0xFFAEEA00),
                          imagebackgroundcolor: Color(0xFFAEEA00),
                          fontValue: 16,
                          fonttext: 16,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleNoSymbol(
                          text: cubit.tActivityPeriod(),
                          number:
                              '${state.creditLimitStartDate}  -  ${state.creditLimitEndDate}',
                          image: "assets/images/calendar-icon.png",
                          color: Color(0xFF263238),
                          imagebackgroundcolor: Color(0xFF263238),
                          fontValue: 10,
                          fonttext: 12,
                        ),
                      ],
                    );
                  }
                  return TitleContainers(
                    text: cubit.tCreditLimit(),
                    number: '${state.credit}',
                    image: "assets/images/debit-card.png",
                    color: Color(0xFFAEEA00),
                    imagebackgroundcolor: Color(0xFFAEEA00),
                    fontValue: 16,
                    fonttext: 16,
                  );
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
                        TitleNoSymbol(
                          text: cubit.tCLIENT(),
                          number: '${state.numberdash.clientsCount}',
                          image: "assets/images/value.png",
                          color: redDashBoard,
                          imagebackgroundcolor: Color(0xFFee3a3b),
                          fontValue: 16,
                          fonttext: 16,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleContainers(
                          text: cubit.tTotalDebts(),
                          number: "${state.numberdash.totalDebt}",
                          image: "assets/images/graph.png",
                          color: orangDashBoard,
                          imagebackgroundcolor: Color(0xFFf2a24e),
                          fontValue: 16,
                          fonttext: 16,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TitleContainers(
                          text: cubit.tTotalPayments(),
                          number: "${state.numberdash.totalPayment}",
                          image: "assets/images/debit-card.png",
                          color: purpleDashBoard,
                          imagebackgroundcolor: Color(0xFFaa4cec),
                          fontValue: 16,
                          fonttext: 16,
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
              Text(
                cubit.tRecentOrders(),
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
