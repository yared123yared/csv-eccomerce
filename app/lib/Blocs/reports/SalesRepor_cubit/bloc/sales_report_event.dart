part of 'sales_report_bloc.dart';

@immutable
abstract class SalesReportEvent {
  const SalesReportEvent();
}

class FeatchSalesReportEvent extends SalesReportEvent {}
