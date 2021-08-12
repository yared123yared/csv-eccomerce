import 'dart:async';
import 'package:app/models/category/categories.dart';
import 'package:app/models/product/product.dart';
import 'package:equatable/equatable.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
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
      //  int page = state.page;
      try {
        List<Data> products = (await this.productRepository.getProducts(page));

        print("This is the data that come from the repository $products");
        if (products == []) {
          print("failed to fetch data");

          yield ProductOperationFailure(
              message: "Failed to fetch products",
              page: page,
              products: state.products,
              selectedCategoryId: state.selectedCategoryId);
        } else {
          // List<Data> paginated_products = state.products;
          print("This is the state products.${productList}");
          print("Page number: $page , category Id : ");
          // for (int i = 0; i < products.length; i++) {
          //   if (paginated_products.contains(products[i])) {
          //   } else {
          //     paginated_products.add(products[i]);
          //   }
          // }
          productList.addAll(products);

          yield ProductLoadSuccess(
              products: productList,
              selectedCategoryId: state.selectedCategoryId,
              page: page);
          // print(productList[0].firstPageUrl);
        }
      } catch (e) {}
    } else if (event is SelectEvent) {
      //
      print("Select event i scalled");

      List<Data> selected_categories = [];
      print("Product List:${productList.length}");

      // productList.map((product) {
      //   print("entered to map");
      //   List<Categories>? product_cat = product.categories;
      //   product_cat!.map((category) {
      //     if (category.id == event.categoryId) {
      //       print("Category Matched: category.id");
      //       selected_categories.add(product);
      //     }
      //   }).toList();
      // });

      for (int i = 0; i < productList.length; i++) {
        Iterable<int> productCatID =
            productList[i].categories!.map((e) => e.id).cast<int>();
        print("This is the category ID for th product: ${productCatID}");
        if (productCatID.contains(event.categories.id)) {
          selected_categories.add(productList[i]);
        }
        // for (int j = 0; j < product_cat.length; j++) {
        //   if (product_cat[j].id == event.categoryId) {
        //     print("Category matched: ${product_cat[i].id}");
        //     selected_categories.add(productList[i]);
        //     return;
        //   }
        // }
        // }
        print("These are teh selected category: ${selected_categories}");

        yield (ProductLoadSuccess(
            page: state.page,
            products: selected_categories,
            selectedCategoryId: event.categories.id!.toInt()));
      }
    } else if (event is AddProduct) {
      List<Data> cart_product = state.products;

      for (int i = 0; i < cart_product.length; i++) {
        if (cart_product[i] == cart_product[i]) {
          cart_product[i] = cart_product[i];
        }
      }
      yield ProductLoadSuccess(
          products: cart_product,
          selectedCategoryId: state.selectedCategoryId,
          page: state.page);
      print("Add Product is called");
    } else if (event is LazyFetchProduct) {
      // yield LazyProductLoading();

      try {
        page++;
        List<Data> products = (await this.productRepository.getProducts(page));

        print("This is the data that come from the repository $products");
        if (products == []) {
          page--;
          print("failed to fetch data");

          yield ProductOperationFailure(
              message: "Failed to fetch products",
              page: page,
              products: state.products,
              selectedCategoryId: state.selectedCategoryId);
        } else {
          // List<Data> paginated_products = state.products;
          print("This is the state products.${productList}");
          print("Page number: $page , category Id : ");

          // for (int i = 0; i < products.length; i++) {
          //   if (paginated_products.contains(products[i])) {
          //   } else {
          //     paginated_products.add(products[i]);
          //   }
          // }

          productList.addAll(products);

          yield ProductLoadSuccess(
              products: productList,
              selectedCategoryId: state.selectedCategoryId,
              page: page);
          print("Finished yielding");
          // print(productList[0].firstPageUrl);
        }
      } catch (e) {}
    }
  }
}
