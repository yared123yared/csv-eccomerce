part of 'singleproduct_bloc.dart';

@immutable
class SingleproductState extends Equatable {
  Data products;
  SingleproductState({required this.products});

  @override
  List<Object> get props => [products];
}
