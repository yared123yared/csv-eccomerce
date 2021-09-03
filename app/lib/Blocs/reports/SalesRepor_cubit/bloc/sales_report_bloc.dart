import 'dart:async';

import 'package:app/data_provider/reports/salesReport_data_provider.dart';
import 'package:app/models/repoets_model/sales_report_models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sales_report_event.dart';
part 'sales_report_state.dart';

class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportState> {
  final SalesReportDataProvider salesReportDataProvider;
  SalesReportBloc(this.salesReportDataProvider) : super(SalesReportInitial());

  @override
  Stream<SalesReportState> mapEventToState(
    SalesReportEvent event,
  ) async* {
    if (event is FeatchSalesReportEvent) {
      yield SalesReportLoadingState();
      try {
        final salesReports = await salesReportDataProvider.getSalesReport();
        yield SalesReportSuccessState(
          salesReports,
        );
      } catch (e) {
        yield SalesReportErrorState(e.toString());
      }
    } else if (event is SearchSealsReportEvent) {
      try {
        final searchOrder = await salesReportDataProvider.getSearchSalesReport(
            nameSearch: event.searchName);
        yield SearchSalesReportSuccessState(searchOrder);
      } catch (e) {
        yield SalesReportErrorState(e.toString());
      }
    } else if (event is FromToReportEvent) {
      yield FromToSalesReportLoadingState();
      try {
        final fromToSalesReport =
            await salesReportDataProvider.getFromToSalesReport(
                fromDate: event.fromDate, toDate: event.toDate);
        yield FromToSalesReportSuccessState(fromToSalesReport);
      } catch (e) {
        yield SalesReportErrorState(e.toString());
      }
    }
  }
}
