part of 'monthly_chart_bloc.dart';

@immutable
abstract class MonthlyChartEvent {
  const MonthlyChartEvent();
}

class FeatchMonthlyChartEvent extends MonthlyChartEvent {
  final String dateFromSearch;

  FeatchMonthlyChartEvent(this.dateFromSearch);
}
