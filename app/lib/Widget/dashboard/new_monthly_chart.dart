import 'package:app/Blocs/dashBoard/monthlyChart/bloc/monthly_chart_bloc.dart';
import 'package:app/models/dashboard/daliy_chart_model.dart';
import 'package:app/models/dashboard/monthly_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NewMonthlyChart extends StatefulWidget {
  @override
  _NewMonthlyChartState createState() => _NewMonthlyChartState();
}

class _NewMonthlyChartState extends State<NewMonthlyChart> {
  late MonthlyChartBloc bloc;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    bloc = BlocProvider.of<MonthlyChartBloc>(context);
    bloc.add(FeatchMonthlyChartEvent(""));

    _tooltipBehavior = TooltipBehavior(enable: true);
    // loadSalesdata();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  // List<SalesDetails> sales = [];
  // List<String> months = ["Apr", "Oct", "Nov"];
  // List<int> totoal = [10, 30, 5];

  // void loadSalesdata() {
  //   for (int i = 0; i < months.length; i++) {
  //     sales.add(SalesDetails(months[i], totoal[i]));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyChartBloc, MonthlyChartState>(
      builder: (context, state) {
        if (state is MonthlyChartInitial) {
          //print("Monthly Data MonthlyChartInitial");
          return Center(child: CircularProgressIndicator());
        } else if (state is MonthlyChartLogingState) {
            //print("Monthly Data MonthlyChartLogingState");
          return Center(child: CircularProgressIndicator());
        } else if (state is MonthlyChartSuccessState) {
          // print("Monthly Data MonthlyChartSuccessState");
          return Container(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: _tooltipBehavior,
              series: <SplineSeries>[
                SplineSeries<MonthlyChartModel, String>(
                  name: "Mobrgly Debt Collection",
                  dataSource: state.monthlyChart,
                  xValueMapper: (MonthlyChartModel sales, _) => sales.months,
                  yValueMapper: (MonthlyChartModel sales, _) =>
                      double.parse(sales.total),
                  color: Color(0xff858eab),
                  width: 4,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  dashArray: <double>[5, 5],
                ),
              ],
            ),
          );
        }
        return Text("No Data");
      },
    );
  }
}

// class SalesDetails {
//   final String month;
//   final int salesCount;

//   SalesDetails(this.month, this.salesCount);
// }
