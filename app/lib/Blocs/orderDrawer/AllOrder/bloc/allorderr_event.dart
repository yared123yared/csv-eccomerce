part of 'allorderr_bloc.dart';

@immutable
abstract class AllorderrEvent {}

class FeatcAllorderrEvent extends AllorderrEvent {}

class SearchGetAllorderrEvent extends AllorderrEvent {
  final String searchName;

  SearchGetAllorderrEvent(this.searchName);
}
