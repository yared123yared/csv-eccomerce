import 'dart:async';

import 'package:app/data_provider/dashboard/monthly_chart_data_provider.dart';
import 'package:app/models/dashboard/monthly_chart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'monthly_chart_event.dart';
part 'monthly_chart_state.dart';

class MonthlyChartBloc extends Bloc<MonthlyChartEvent, MonthlyChartState> {
  final MOnthlyChartDataProvider mOnthlyChartDataProvider;
  MonthlyChartBloc(this.mOnthlyChartDataProvider)
      : super(MonthlyChartInitial());

  @override
  Stream<MonthlyChartState> mapEventToState(
    MonthlyChartEvent event,
  ) async* {
    if (event is FeatchMonthlyChartEvent) {
      yield MonthlyChartLogingState();
      try {
        var monthChart = await mOnthlyChartDataProvider
            .getMonthlyChart(event.dateFromSearch);

        List<MonthlyChartModel> salesMonthly = [];

        List<String> datamontlylist = [];
        List<String> totalMontlylist = [];

        for (int i = 0; i < monthChart.length; i++) {
          datamontlylist.add(monthChart[i].months.substring(0, 4));
          totalMontlylist.add(monthChart[i].total);
        }

        for (int i = 0; i < datamontlylist.length; i++) {
          salesMonthly.add(MonthlyChartModel(
              months: datamontlylist[i], total: totalMontlylist[i]));
        }

        yield MonthlyChartSuccessState(salesMonthly);
      } catch (e) {
        yield MonthlyChartErrorState(e.toString());
      }
    }
  }

 
}
