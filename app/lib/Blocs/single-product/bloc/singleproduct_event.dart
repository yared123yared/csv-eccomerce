part of 'singleproduct_bloc.dart';

@immutable
abstract class SingleproductEvent extends Equatable {
  const SingleproductEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends SingleproductEvent {}

class Initial extends SingleproductEvent {
  Data products;
  Initial({required this.products});
}
