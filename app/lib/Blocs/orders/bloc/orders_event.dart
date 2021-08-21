part of 'orders_bloc.dart';

class OrdersEvent {}

class CreateOrderEvent extends OrdersEvent {
  final Request? request;
  CreateOrderEvent({required this.request});
}

class CartCheckoutEvent extends OrdersEvent {
  final List<Data> cartProducts;
  CartCheckoutEvent({required this.cartProducts});
}

class ClientAddEvent extends OrdersEvent {
  final Client client;
  ClientAddEvent({required this.client});
}

class PaymentAddEvent extends OrdersEvent {
  final Payment payment;
  PaymentAddEvent({required this.payment});
}
