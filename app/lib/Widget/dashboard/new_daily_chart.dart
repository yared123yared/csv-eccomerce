import 'package:app/Blocs/dashBoard/dailyChart/bloc/daily_chart_bloc.dart';
import 'package:app/models/dashboard/daliy_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NewDailyChart extends StatefulWidget {
  @override
  _NewDailyChartState createState() => _NewDailyChartState();
}

class _NewDailyChartState extends State<NewDailyChart> {
  //Api Bloc
  late DailyChartBloc bloc;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    bloc = BlocProvider.of<DailyChartBloc>(context);
    bloc.add(FeatchDailyChartEvent(""));

    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChartBloc, DailyChartState>(
      builder: (context, state) {
        if (state is DailyChartInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DailyChartLoadingSate) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DailyChartSuccessSate) {
          return Column(
            children: [
              Container(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior: _tooltipBehavior,
                  series: <SplineSeries>[
                    SplineSeries<DailyChartModel, String>(
                      name: "Daily Debt Collection",
                      dataSource: state.daliyChart,
                      xValueMapper: (DailyChartModel daily, _) => daily.date,
                      yValueMapper: (DailyChartModel daily, _) =>
                          double.parse(daily.total),
                      color: Color(0xff858eab),
                      width: 4,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      dashArray: <double>[5, 5],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
