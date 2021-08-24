import 'dart:async';

import 'package:app/data_provider/reports/collection_data_provider.dart';
import 'package:app/models/repoets_model/collection_report_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionDataProvider collectionDataProvider;
  CollectionBloc(this.collectionDataProvider) : super(CollectionInitial());

  @override
  Stream<CollectionState> mapEventToState(
    CollectionEvent event,
  ) async* {
    if (event is FeatchCollectionEvent) {
      yield CollectionLoadingState();
      try {
        var collection = await collectionDataProvider.getCollectionReport();
        yield CollectionSuccessState(collection);
      } catch (e) {
        yield CollectionErrorState(e.toString());
      }
    }
  }
}
