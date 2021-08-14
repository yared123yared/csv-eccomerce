part of 'orders_bloc.dart';

class OrdersState {
  final bool orderCreated;
  OrdersState({required this.orderCreated});
}

class OrdersInitial extends OrdersState {
  OrdersInitial() : super(orderCreated: false);
}

class OrderCreatedSuccess extends OrdersState {
  OrderCreatedSuccess() : super(orderCreated: true);
}

class OrderIsBeingCreating extends OrdersState {
  OrderIsBeingCreating() : super(orderCreated: false);
}

class OrderCreatingFailed extends OrdersState {
  final String message;
  OrderCreatingFailed({required this.message}) : super(orderCreated: false);
}
