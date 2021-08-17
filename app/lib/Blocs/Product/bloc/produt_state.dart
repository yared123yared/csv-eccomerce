part of 'produt_bloc.dart';

class ProductState {
  final int page;
  final int? selectedCategoryId;
  final String? searchProductName;
  final List<Data> products;

  ProductState(
      {required this.page,
      this.selectedCategoryId,
      required this.products,
      this.searchProductName});

  // @override
  // // TODO: implement props
  // List<Object?> get props => [products];
}

class ProductInitial {}

class ProductLoading extends ProductState {
  ProductLoading() : super(products: [], selectedCategoryId: null, page: 1);
}

class LazyProductLoading extends ProductState {
  LazyProductLoading() : super(products: [], selectedCategoryId: 0, page: 0);
}

class ProductLoadSuccess extends ProductState {
  final List<Data> products;
  final int? selectedCategoryId;
  final int page;
  final String? searchProductName;
  ProductLoadSuccess(
      {required this.selectedCategoryId,
      this.searchProductName,
      required this.products,
      required this.page})
      : super(
            products: products,
            selectedCategoryId: selectedCategoryId,
            page: page);

  @override
  List<Object> get props => [products];
}

class ProductOperationFailure extends ProductState {
  final String message;
  final int? selectedCategoryId;
  final List<Data> products;
  final int page;
  ProductOperationFailure(
      {required this.message,
      required this.selectedCategoryId,
      required this.page,
      required this.products})
      : super(
            products: products,
            selectedCategoryId: selectedCategoryId,
            page: page);
}
