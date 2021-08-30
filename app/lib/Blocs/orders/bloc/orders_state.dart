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
  final Request request;
  OrderCreatedSuccess({required this.request}) : super(orderCreated: true, request: Request());
}

class OrderIsBeingCreating extends OrdersState {
  final Request request;
  OrderIsBeingCreating({required this.request})
      : super(orderCreated: false, request: request);
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
