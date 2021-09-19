import 'dart:async';

import 'package:app/data_provider/orderDrawer/order_details_data_provider.dart';
import 'package:app/models/OrdersDrawer/order_detailsModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'allorderdetails_event.dart';
part 'allorderdetails_state.dart';

class AllorderdetailsBloc
    extends Bloc<AllorderdetailsEvent, AllorderdetailsState> {
  final OrderDetailsDataProvider orderDetailsDataProvider;
  AllorderdetailsBloc(this.orderDetailsDataProvider)
      : super(AllorderdetailsInitial());

  @override
  Stream<AllorderdetailsState> mapEventToState(
    AllorderdetailsEvent event,
  ) async* {
    if (event is FeatchOrderDetailsEvent) {
      yield OrderDetailsALoadingState();
      try {
        final orderDetails =
            await orderDetailsDataProvider.getAllOrderDetails(event.id);
        yield OrderDetailsASuccessState(orderDetails);
      } catch (e) {
        yield OrderDetailsAErrorState(e.toString());
      }
    }
  }
}
