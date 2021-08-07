part of 'cart_bloc.dart';

@immutable
class CartState {
  final int counter;
  const CartState({required this.counter});

  @override
  List<Object> get props => [counter];
}

class CartInitial extends CartState {
  CartInitial() : super(counter: 0);
}
