part of 'collection_bloc.dart';

@immutable
abstract class CollectionState {}

class CollectionInitial extends CollectionState {}

class CollectionLoadingState extends CollectionState {}

class CollectionSuccessState extends CollectionState {
  final List<DataCollection> collextions;

  CollectionSuccessState(
    this.collextions,
  );
}

class CollectionErrorState extends CollectionState {
  final String message;

  CollectionErrorState(this.message);
}

class SearchCollectionLoadingState extends CollectionState {}

class SearchCollectionSuccessState extends CollectionState {
  final List<DataCollection> searchCollextions;

  SearchCollectionSuccessState(this.searchCollextions);
}

class FromToCollectionLoadingState extends CollectionState {}

class FromToCollectionSuccessState extends CollectionState {
  final List<DataCollection> fromTlCollextions;

  FromToCollectionSuccessState(this.fromTlCollextions);
}

