import 'dart:async';

import 'package:app/data_provider/dashboard/daliy_chart_data_provider.dart';
import 'package:app/models/dashboard/daliy_chart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'daily_chart_event.dart';
part 'daily_chart_state.dart';

class DailyChartBloc extends Bloc<DailyChartEvent, DailyChartState> {
  final DailyChartDataProvider dailyChartDataProvider;

  DailyChartBloc(this.dailyChartDataProvider) : super(DailyChartInitial());

  @override
  Stream<DailyChartState> mapEventToState(
    DailyChartEvent event,
  ) async* {
    if (event is FeatchDailyChartEvent) {
      yield DailyChartLoadingSate();
      try {
        var dailyChart =
            await dailyChartDataProvider.getDailyChart(event.dateFromSelect);
        List<DailyChartModel> sales = [];

        List<String> dataList = [];
        List<String> totalList = [];

        for (int i = 0; i < dailyChart.length; i++) {
          dataList.add(dailyChart[i].date.substring(5));
          totalList.add(dailyChart[i].total);
        }

        for (int i = 0; i < dataList.length; i++) {
          sales.add(DailyChartModel(dataList[i], totalList[i]));
        }

        yield DailyChartSuccessSate(sales);
      } catch (e) {
        yield DailyChartErrorState(e.toString());
      }
    }
  }
}
