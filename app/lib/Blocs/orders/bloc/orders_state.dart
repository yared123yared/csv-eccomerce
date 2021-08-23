part of 'orders_bloc.dart';

class OrdersState {
  final bool orderCreated;
  final Request request;
  OrdersState({required this.orderCreated, required this.request});
}

class OrdersInitial extends OrdersState {
  OrdersInitial() : super(orderCreated: false, request: Request());
}

class OrderCreatedSuccess extends OrdersState {
  OrderCreatedSuccess() : super(orderCreated: true, request: Request());
}

class OrderIsBeingCreating extends OrdersState {
  OrderIsBeingCreating() : super(orderCreated: false, request: Request());
}

class OrderCreatingFailed extends OrdersState {
  final String message;
  OrderCreatingFailed({required this.message})
      : super(orderCreated: false, request: Request());
}

class RequestUpdateSuccess extends OrdersState {
  final Request request;
  // OrdersCheckedOutSuccess();
  RequestUpdateSuccess({required this.request})
      : super(orderCreated: false, request: request);
}
