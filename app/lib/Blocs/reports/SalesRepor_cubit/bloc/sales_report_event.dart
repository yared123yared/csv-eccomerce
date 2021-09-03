part of 'sales_report_bloc.dart';

@immutable
abstract class SalesReportEvent {
  const SalesReportEvent();
}

class FeatchSalesReportEvent extends SalesReportEvent {}

class SearchSealsReportEvent extends SalesReportEvent {
  final String searchName;

  SearchSealsReportEvent(this.searchName);
}

class FromToReportEvent extends SalesReportEvent {
  final String fromDate;
  final String toDate;

  FromToReportEvent({required this.fromDate, required this.toDate});
}
