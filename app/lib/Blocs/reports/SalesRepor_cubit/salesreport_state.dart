abstract class SalesReportState {}

class ReportInitialState extends SalesReportState {}

class SelectFormTimePickerState extends SalesReportState {}

class SelectToTimePickerState extends SalesReportState {}

class ClearAllButtonState extends SalesReportState {}

class ClearDateOnlyState extends SalesReportState {}

class DropdownMenuItemState extends SalesReportState {}

class FeatchDataLoagingState extends SalesReportState {}

class FeatchDataSucessState extends SalesReportState {}

class FeatchDataErrorState extends SalesReportState {
  final String error;

  FeatchDataErrorState(this.error);
}


class SearchLoadingState extends SalesReportState {}