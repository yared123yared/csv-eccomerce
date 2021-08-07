part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {}
