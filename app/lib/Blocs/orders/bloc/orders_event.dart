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

// add payment details
class AddPaymentWhenEvent extends OrdersEvent {
  final String when;
  AddPaymentWhenEvent({required this.when});
}

class AddPaymentMethodEvent extends OrdersEvent {
  final String method;
  AddPaymentMethodEvent({required this.method});
}

class AddPaymentTypeEvent extends OrdersEvent {
  final String type;
  AddPaymentTypeEvent({required this.type});
}

class AddTransactionIdEvent extends OrdersEvent {
  final String transactionId;
  AddTransactionIdEvent({required this.transactionId});
}

class AddPaidAmountEvent extends OrdersEvent {
  final int amount;
  AddPaidAmountEvent({required this.amount});
}

class AddRemainingAmountEvent extends OrdersEvent {
  final int amount;
  AddRemainingAmountEvent({required this.amount});
}

class AddTotalEvent extends OrdersEvent {
  final int total;
  AddTotalEvent({required this.total});
}
class SetRequestEvent extends OrdersEvent {
  final Request request;
  SetRequestEvent({required this.request});
}

class FetchOrderToBeUpdated extends OrdersEvent {
  final String id;
  FetchOrderToBeUpdated({required this.id});
}

class AddToCart extends OrdersEvent {
  final CartItem cart;
  AddToCart({required this.cart});
}
class RemoveFromCart extends OrdersEvent {
  final CartItem cart;
  RemoveFromCart({required this.cart});
}

class UpdateOrderEvent extends OrdersEvent {
  final Request request;
  UpdateOrderEvent({required this.request});
}
