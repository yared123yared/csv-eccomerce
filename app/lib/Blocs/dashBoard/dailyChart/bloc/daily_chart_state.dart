part of 'daily_chart_bloc.dart';

@immutable
abstract class DailyChartState {
  const DailyChartState();
}

class DailyChartInitial extends DailyChartState {}

class DailyChartLoadingSate extends DailyChartState {}

class DailyChartSuccessSate extends DailyChartState {
  final List<DailyChartModel> daliyChart;
  // final List<String> dataList;
  // final List<String> totalList;

  DailyChartSuccessSate(this.daliyChart);
}

class DailyChartErrorState extends DailyChartState {
  final String message;

  DailyChartErrorState(this.message);
}
