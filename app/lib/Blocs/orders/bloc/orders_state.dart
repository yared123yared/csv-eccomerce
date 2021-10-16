part of 'orders_bloc.dart';

class OrdersState {
  final bool orderCreated;
  final Request request;
  final double? credit;
  OrdersState({required this.orderCreated, required this.request, this.credit});
}

class OrdersInitial extends OrdersState {
  OrdersInitial() : super(orderCreated: false, request: Request());
}

class OrderCreatedSuccess extends OrdersState {
  final Request request;
  OrderCreatedSuccess({required this.request})
      : super(orderCreated: true, request: Request());
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
  final double? credit;
  // OrdersCheckedOutSuccess();
  RequestUpdateSuccess({required this.request, this.credit})
      : super(orderCreated: false, request: request, credit: credit);
}

class FetchingOrderToBeUpdated extends OrdersState {
  final Request request;
  FetchingOrderToBeUpdated({required this.request})
      : super(orderCreated: false, request: request);
}

class FetchingOrderToBeUpdatedFailed extends OrdersState {
  FetchingOrderToBeUpdatedFailed()
      : super(orderCreated: false, request: Request());
}

class FetchingOrderToBeUpdatedSuccess extends OrdersState {
  final Request request;
  final List<OrderToBeUpdated> data;
  int? addressId;
  Client? client;
  final double? credit;
  FetchingOrderToBeUpdatedSuccess({
    required this.data,
    required this.request,
    this.addressId,
    this.client,
    this.credit,
  }) : super(orderCreated: false, request: Request());
}

class OrderUpdateSuccess extends OrdersState {
  final Request request;
  final double? credit;
  OrderUpdateSuccess({required this.request, required this.credit})
      : super(orderCreated: true, request: request);
}

class OrderUpdating extends OrdersState {
  final Request request;
  final double? credit;
  OrderUpdating({required this.request, required this.credit})
      : super(orderCreated: false, request: request);
}

class OrderUpdatingFailed extends OrdersState {
  final Request request;
  final String message;
  final double? credit;

  OrderUpdatingFailed(
      {required this.request, required this.message, required this.credit})
      : super(orderCreated: false, request: request);
}
