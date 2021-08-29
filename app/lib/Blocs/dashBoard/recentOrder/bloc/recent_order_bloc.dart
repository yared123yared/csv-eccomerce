import 'dart:async';

import 'package:app/data_provider/dashboard/recent_data_provider.dart';
import 'package:app/models/dashboard/recent_order_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recent_order_event.dart';
part 'recent_order_state.dart';

class RecentOrderBloc extends Bloc<RecentOrderEvent, RecentOrderState> {
  final RecentDataProvider recentDataProvider;
  RecentOrderBloc(this.recentDataProvider) : super(RecentOrderInitial());

  @override
  Stream<RecentOrderState> mapEventToState(
    RecentOrderEvent event,
  ) async* {
    if (event is FeatchRecentOrderEvent) {
      yield RecentOrderLoadingState();
      try {
        var recentOrder = await recentDataProvider.getRecentData();
        yield RecentOrderSuccessState(
          recentOrder,
        );
      } catch (e) {
        yield RecentOrderErrorState(e.toString());
      }
    }
  }
}
