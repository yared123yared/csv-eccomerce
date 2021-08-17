part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final Data singleProduct;
  AddProduct({required this.singleProduct});
}

class RemoveProduct extends CartEvent {
  final Data singleProduct;
  RemoveProduct({required this.singleProduct});
}
