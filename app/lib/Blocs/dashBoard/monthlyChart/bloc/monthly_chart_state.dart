part of 'monthly_chart_bloc.dart';

@immutable
abstract class MonthlyChartState {
  const MonthlyChartState();
}

class MonthlyChartInitial extends MonthlyChartState {}

class MonthlyChartLogingState extends MonthlyChartState {}

class MonthlyChartSuccessState extends MonthlyChartState {
  final List<MonthlyChartModel> monthlyChart;

  MonthlyChartSuccessState(this.monthlyChart);
}

class MonthlyChartErrorState extends MonthlyChartState {
  final String message;

  MonthlyChartErrorState(this.message);
}
