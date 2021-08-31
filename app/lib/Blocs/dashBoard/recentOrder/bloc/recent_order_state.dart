part of 'recent_order_bloc.dart';

@immutable
abstract class RecentOrderState {}

class RecentOrderInitial extends RecentOrderState {}

class RecentOrderLoadingState extends RecentOrderState {}

class RecentOrderSuccessState extends RecentOrderState {
  final List<RecentOrderData> recentOrder;

  RecentOrderSuccessState(this.recentOrder);
}

class RecentOrderErrorState extends RecentOrderState {
  final String error;

  RecentOrderErrorState(this.error);
}

class SearchRecentOrderLoadingState extends RecentOrderState {}

class SearchRecentOrderSuccessState extends RecentOrderState {
  final List<RecentOrderData> searchRecentOrder;

  SearchRecentOrderSuccessState(this.searchRecentOrder);
}
