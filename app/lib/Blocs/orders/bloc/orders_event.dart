part of 'orders_bloc.dart';

class OrdersEvent {}

class CreateOrderEvent extends OrdersEvent {
  final Request? request;
  CreateOrderEvent({required this.request});
}
