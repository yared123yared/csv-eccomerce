part of 'produt_bloc.dart';

@immutable
abstract class ProductEvent {
  const ProductEvent();
}

class FetchProduct extends ProductEvent {
  const FetchProduct();
}

class LazyFetchProduct extends ProductEvent {
  const LazyFetchProduct();
}

class SelectEvent extends ProductEvent {
  final Categories categories;
  SelectEvent({required this.categories});
}

class SingleProductUpdate extends ProductEvent {
  final bool? increment;
  final Data singleProduct;
  SingleProductUpdate({required this.singleProduct, required this.increment});
}

class SearchEvent extends ProductEvent {
  // final bool isSubmited;
  final String productName;
  SearchEvent({required this.productName});
}

class AllCategories extends ProductEvent {}
