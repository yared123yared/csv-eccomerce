part of 'daily_chart_bloc.dart';

@immutable
abstract class DailyChartEvent {
  const DailyChartEvent();
}

class FeatchDailyChartEvent extends DailyChartEvent {
  final String dateFromSelect;

  FeatchDailyChartEvent(this.dateFromSelect);
}
