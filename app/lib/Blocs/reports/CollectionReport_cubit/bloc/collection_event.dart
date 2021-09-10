part of 'collection_bloc.dart';

@immutable
abstract class CollectionEvent {
  const CollectionEvent();
}

class FeatchCollectionEvent extends CollectionEvent {}

class SearchCollectionEvent extends CollectionEvent {
  final String searchName;

  SearchCollectionEvent(this.searchName);
}


class FromToCollectionEvent extends CollectionEvent {
  final String fromDate;
  final String toDate;

  FromToCollectionEvent({required this.fromDate, required this.toDate});
}
