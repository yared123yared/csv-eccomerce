import 'dart:async';

import 'package:app/data_provider/orderDrawer/all_order_data_provider.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'allorderr_event.dart';
part 'allorderr_state.dart';

class AllorderrBloc extends Bloc<AllorderrEvent, AllorderrState> {
  final AllOrderDataProvider allOrderDataProvider;
  AllorderrBloc(this.allOrderDataProvider) : super(AllorderrInitial());

  @override
  Stream<AllorderrState> mapEventToState(
    AllorderrEvent event,
  ) async* {
    if (event is FeatcAllorderrEvent) {
      yield AllOrderrLoadingState();
      try {
        var allorderstat = await allOrderDataProvider.getAllOrders();
        yield AllOrdersSuccessState(allorderstat);
      } catch (e) {
        yield AllorderrErrorState(e.toString());
      }
    }
  }
}
