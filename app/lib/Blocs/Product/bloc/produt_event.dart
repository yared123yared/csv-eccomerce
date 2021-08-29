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

class AddProduct extends ProductEvent {
  final Data singleProduct;
  AddProduct({required this.singleProduct});
}

class SearchEvent extends ProductEvent {
  // final bool isSubmited;
  final String productName;
  SearchEvent({required this.productName});
}
class AllCategories extends ProductEvent{
  
}
