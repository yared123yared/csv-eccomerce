part of 'produt_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class FetchProduct extends ProductEvent {
  const FetchProduct();

  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final id;
  AddProduct({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
