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
