part of 'cart_bloc.dart';

@immutable
class CartState {
  final int counter;
  final List<Data> cartProducts;
  const CartState({required this.counter, required this.cartProducts});

  @override
  List<Object> get props => [counter];
}

class CartInitial extends CartState {
  CartInitial() : super(counter: 0, cartProducts: []);
}
