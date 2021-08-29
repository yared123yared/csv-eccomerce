part of 'recent_order_bloc.dart';

@immutable
abstract class RecentOrderEvent {
  List<Object> get props => [];
}

class FeatchRecentOrderEvent extends RecentOrderEvent {}
