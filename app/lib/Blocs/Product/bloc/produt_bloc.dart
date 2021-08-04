import 'dart:async';
import 'package:app/models/product/product.dart';
import 'package:equatable/equatable.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'produt_event.dart';
part 'produt_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<Data> productList = [];
  int page = 0;
  ProductBloc({required this.productRepository})
      : assert(productRepository != null),
        super(ProductLoading());
  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchProduct) {
      print("fetch event is called");
      yield ProductLoading();
      try {
        page++;
        List<Data> products = await this.productRepository.getProducts(page);
        print("This is the data that come from the repository $products");
        if (products == null) {
          page--;
          yield ProductOperationFailure(message: "Failed to fetch products");
        } else {
          productList.addAll(products);
          yield ProductLoadSuccess(products: productList);
          // print(productList[0].firstPageUrl);
        }
      } catch (e) {}
    }
  }
}
