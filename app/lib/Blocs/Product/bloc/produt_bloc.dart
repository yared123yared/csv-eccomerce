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

  StreamController<List<Data>> _prodcutListController = StreamController();

  Stream<List<Data>> get productListStream => _prodcutListController.stream;

  // ProductBloc({required this.productRepository})
  //     : assert(productRepository != null),
  //       super(ProductLoading());
  ProductBloc(this.productRepository) : super(ProductLoading()) {
    _prodcutListController.add(productList);
  }

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
    } else if (event is AddProduct) {
      int id = event.id;
      print("This is the id ${id}");
      Data product = new Data();
      for (int i = 0; i < productList.length; i++) {
        if (productList[i].id == id) {
          //  const product=[...productList];
          print("Updated to this ${productList[i].id}");
          // productList[i].order += 1;
          product = productList[i];
        }
      }
      product.order += 1;
      print("This is the add method");
      print(product.order);
      yield ProductUpdated(product: product);
    }
  }
}
