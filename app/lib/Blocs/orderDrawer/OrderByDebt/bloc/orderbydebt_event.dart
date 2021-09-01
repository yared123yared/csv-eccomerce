part of 'orderbydebt_bloc.dart';

@immutable
abstract class OrderbydebtEvent {}

class FeatchOrderbydebtEvent extends OrderbydebtEvent {}

class SearchOrderBydebtEvent extends OrderbydebtEvent {
  final String searchName;

  SearchOrderBydebtEvent(this.searchName);
}
