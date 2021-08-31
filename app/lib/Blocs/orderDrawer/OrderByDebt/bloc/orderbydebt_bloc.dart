import 'dart:async';

import 'package:app/data_provider/orderDrawer/orderbyDebt_data_provider.dart';
import 'package:app/models/OrdersDrawer/orderbyDebt_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'orderbydebt_event.dart';
part 'orderbydebt_state.dart';

class OrderbydebtBloc extends Bloc<OrderbydebtEvent, OrderbydebtState> {
  final OrderByDebtDataProvider orderByDebtDataProvider;
  OrderbydebtBloc(this.orderByDebtDataProvider) : super(OrderbydebtInitial());

  @override
  Stream<OrderbydebtState> mapEventToState(
    OrderbydebtEvent event,
  ) async* {
    if (event is FeatchOrderbydebtEvent) {
      yield OrderbydebtLoadingState();
      try {
        final ordersbydebt = await orderByDebtDataProvider.getOrdersByDebt();
        List<String> grandTotalString = [];
        List<double> grandTotalInt = [];
        List<String> debtTotalString = [];
        List<double> debtTotalInt = [];

        for (int i = 0; i < ordersbydebt.length; i++) {
          grandTotalString.add(ordersbydebt[i].total);
          debtTotalString.add(ordersbydebt[i].amountRemaining);
        }
        grandTotalInt = grandTotalString.map(double.parse).toList();
        debtTotalInt = debtTotalString.map(double.parse).toList();
        yield OrderbydebtSuccessState(
          ordersbydebt,
          grandTotalInt,
          debtTotalInt,
        );
      } catch (e) {
        yield OrderbydebtErrorState(e.toString());
      }
    } else if (event is SearchOrderBydebtEvent) {
      yield SearchOrderByDebtLoading();
      try {
        final ordersbydebtSearch = await orderByDebtDataProvider
            .getOrdersByDebtSearch(event.searchName);
        List<String> searchgrandTotalString = [];
        List<double> searchgrandTotalInt = [];
        List<String> searchdebtTotalString = [];
        List<double> searchdebtTotalInt = [];

        for (int i = 0; i < ordersbydebtSearch.length; i++) {
          searchgrandTotalString.add(ordersbydebtSearch[i].total);
          searchdebtTotalString.add(ordersbydebtSearch[i].amountRemaining);
        }
        searchgrandTotalInt = searchgrandTotalString.map(double.parse).toList();
        searchdebtTotalInt = searchdebtTotalString.map(double.parse).toList();

        yield SearchOrderByDebtSccessState(
          ordersbydebtSearch,
          searchgrandTotalInt,
          searchdebtTotalInt,
        );
      } catch (e) {
        yield OrderbydebtErrorState(e.toString());
      }
    }
  }
}
