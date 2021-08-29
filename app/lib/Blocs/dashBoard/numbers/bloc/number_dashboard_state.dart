part of 'number_dashboard_bloc.dart';

@immutable
abstract class NumberDashboardState {}

class NumberDashboardInitial extends NumberDashboardState {}

class NumberDashLoadingState extends NumberDashboardState {}

class NumberDashSuccessState extends NumberDashboardState {
  final NumbersDashBoardModel numberdash;

  NumberDashSuccessState(this.numberdash);
}

class NumberDashErrorState extends NumberDashboardState {
  final String error;

  NumberDashErrorState(this.error);
}
