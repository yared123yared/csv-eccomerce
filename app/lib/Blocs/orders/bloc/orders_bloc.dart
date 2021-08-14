import 'dart:async';

import 'package:app/models/request/request.dart';
import 'package:app/repository/orders_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository orderRepository;
  OrdersBloc({required this.orderRepository}) : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is CreateOrderEvent) {
      print("Entered to the order event");
      yield OrderIsBeingCreating();
      bool value = (await this.orderRepository.createOrder(event.request));
      if (value == true) {
        print("Successfully created");
        yield (OrderCreatedSuccess());
      } else {
        print("failed to create");
        yield (OrderCreatingFailed(message: "Failed to create order"));
      }
    }
  }
}
