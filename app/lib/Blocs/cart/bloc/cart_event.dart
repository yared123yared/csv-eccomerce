part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class InitializeCart extends CartEvent {}

class AddProduct extends CartEvent {
  final Data singleProduct;
  final increment;
  AddProduct({required this.singleProduct, required this.increment});
}

class RemoveProduct extends CartEvent {
  final Data singleProduct;
  RemoveProduct({required this.singleProduct});
}
