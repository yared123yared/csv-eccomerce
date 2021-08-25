part of 'sales_report_bloc.dart';

@immutable
abstract class SalesReportState {}

class SalesReportInitial extends SalesReportState {}

class SalesReportLoadingState extends SalesReportState {}

class SalesReportSuccessState extends SalesReportState {
  final List<DataSaleReport> salesReport;


  SalesReportSuccessState(this.salesReport,);
}

class SalesReportErrorState extends SalesReportState {
  final String message;

  SalesReportErrorState(this.message);
}
