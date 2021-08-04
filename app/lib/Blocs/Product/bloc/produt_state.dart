part of 'produt_bloc.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial {}

class ProductLoading extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<Data> products;

  ProductLoadSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductOperationFailure extends ProductState {
  final String message;
  ProductOperationFailure({required this.message});
}
