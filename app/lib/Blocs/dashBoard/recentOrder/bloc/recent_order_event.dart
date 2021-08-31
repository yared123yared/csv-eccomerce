part of 'recent_order_bloc.dart';

@immutable
abstract class RecentOrderEvent {
  const RecentOrderEvent();
}

class FeatchRecentOrderEvent extends RecentOrderEvent {}

class SearchRecentOrderEvent extends RecentOrderEvent {
  final String searchName;

  SearchRecentOrderEvent(this.searchName);
}
