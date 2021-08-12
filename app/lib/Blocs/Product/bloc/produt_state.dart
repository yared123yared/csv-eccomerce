part of 'produt_bloc.dart';

class ProductState {
  final int page;
  final int selectedCategoryId;
  final List<Data> products;

  ProductState(
      {required this.page,
      required this.selectedCategoryId,
      required this.products});

  // @override
  // // TODO: implement props
  // List<Object?> get props => [products];
}

class ProductInitial {}

class ProductLoading extends ProductState {
  ProductLoading() : super(products: [], selectedCategoryId: 0, page: 0);
}

class LazyProductLoading extends ProductState {
  LazyProductLoading() : super(products: [], selectedCategoryId: 0, page: 0);
}

// class ProductUpdated extends ProductState {
//   final Data product;
//   final int selectedCategoryId;
//   final List<Data> products;

//   ProductUpdated(
//       {required this.selectedCategoryId,
//       required this.products,
//       required this.product})
//       : super(products: products, selectedCategoryId: selectedCategoryId);

//   @override
//   List<Object> get props => [product];
// }

class ProductLoadSuccess extends ProductState {
  final List<Data> products;
  final int selectedCategoryId;
  final int page;
  ProductLoadSuccess(
      {required this.selectedCategoryId,
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
  final int selectedCategoryId;
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
