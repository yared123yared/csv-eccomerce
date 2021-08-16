abstract class ReportState {}

class ReportInitialState extends ReportState {}

class SelectFormTimePickerState extends ReportState {}

class SelectToTimePickerState extends ReportState {}

class ClearAllButtonState extends ReportState {}

class ClearDateOnlyState extends ReportState {}

class DropdownMenuItemState extends ReportState {}

class FeatchDataLoagingState extends ReportState {}

class FeatchDataSucessState extends ReportState {}

class FeatchDataErrorState extends ReportState {
  final String error;

  FeatchDataErrorState(this.error);
}
