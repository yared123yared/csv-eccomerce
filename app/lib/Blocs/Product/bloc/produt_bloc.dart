import 'dart:async';
import 'dart:io';
import 'package:app/db/db.dart';
import 'package:app/models/category/categories.dart';
import 'package:app/models/product/product.dart';
import 'package:app/utils/connection_checker.dart';
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
  List<Data> selectedCategories = [];
  List<Data> searchedProducts = [];
  int? categoryId = null;
  String? searchProductName = null;
  int page = 1;
  int categoryPage = 1;

  ProductBloc({required this.productRepository})
      : assert(productRepository != null),
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    productList.forEach((product) async {
      await CsvDatabse.instance.createProduct(product);
    });
    bool connected = await ConnectionChecker.CheckInternetConnection();
    print("-is--connected--${connected}");
    if (event is FetchProduct) {
      print("bloc--fetch--product--1");
      productList = [];
      selectedCategories = [];
      categoryId = null;
      searchProductName = null;
      // page = 0;
      categoryPage = 1;
      yield ProductLoading();
      //  int page = state.page;

      try {
        if (!connected) {
          List<Data>? products = await CsvDatabse.instance.readProducts(null);
          if (products == null || products == []) {
            print("bloc--fetch--product--2");
            yield ProductOperationFailure(
              message: "Failed to fetch products",
              page: page,
              products: state.products,
              selectedCategoryId: state.selectedCategoryId,
            );
            return;
          } else {
            print("bloc--fetch--product--3");
            productList = products;
            yield ProductLoadSuccess(
              products: productList,
              selectedCategoryId: state.selectedCategoryId,
              page: page,
            );
            return;
          }
        } else {
          print("bloc--fetch--product--4");

          List<Data> productsFromServer =
              await this.productRepository.getProducts(page, this.categoryId);
          productList = productsFromServer;
          // print("This is the data that come from the repository $products");
          if (productsFromServer == [] || productsFromServer == null) {
            print("bloc--fetch--product--5");

            yield ProductOperationFailure(
              message: "Failed to fetch products",
              page: page,
              products: state.products,
              selectedCategoryId: state.selectedCategoryId,
            );
            return;
          } else {
            print("bloc--fetch--product--6");

            // List<Data> paginated_products = state.products;
            // print("This is the state products.${productList}");
            // print("Page number: $page , category Id : ");
            // for (int i = 0; i < products.length; i++) {
            //   if (productList.contains(products[i])) {
            //   } else {
            //     productList.add(products[i]);
            //   }
            // }
            productsFromServer.forEach((product) async {
              await CsvDatabse.instance.createProduct(product);
            });
            print("bloc--fetch--product--7");

            // List<Data>? products = await CsvDatabse.instance.readProducts(null);
            // if (products != null) {
            //   productList = products;
            // }

            print("bloc--fetch--product--8");

            yield ProductLoadSuccess(
              products: productsFromServer,
              selectedCategoryId: state.selectedCategoryId,
              page: page,
            );
            return;
            // print(productList[0].firstPageUrl);
          }
        }
      } catch (e) {
        print("bloc--fetch--product--fail");
        print(e);
      }
    } else if (event is AllCategories) {
      yield ProductLoadSuccess(
        products: productList,
        page: state.page,
        selectedCategoryId: null,
      );
    } else if (event is SelectEvent) {
      print("select event from product bloc");
      //
      this.selectedCategories = [];
      print("Select event i scalled");
      this.categoryId = event.categories.id;
      // this.page = 1;

      //  filter from the cache
      for (int i = 0; i < productList.length; i++) {
        Iterable<int> productCatID =
            productList[i].categories!.map((e) => e.id).cast<int>();
        print("This is the category ID for th product: ${productCatID}");
        if (productCatID.contains(event.categories.id)) {
          this.selectedCategories.add(productList[i]);
        }
        print("Products: ${this.selectedCategories}");
        yield (ProductLoadSuccess(
            page: page,
            products: this.selectedCategories,
            selectedCategoryId: event.categories.id!.toInt()));
      }
      print("Products: ${this.selectedCategories[0].order}");
    } else if (event is SearchEvent) {
      //
      this.searchedProducts = [];
      print("Search event is scalled");
      this.searchProductName = event.productName;
      this.page = 1;

      //  filter from the cache
      for (int i = 0; i < productList.length; i++) {
        if (productList[i]
            .name!
            .toLowerCase()
            .contains(this.searchProductName.toString().toLowerCase())) {
          this.searchedProducts.add(productList[i]);
        }
      }
      // if (event.isSubmited) {
      //   List<Data> products =
      //       (await this.productRepository.getProducts(page, this.categoryId));
      // }

      yield (ProductLoadSuccess(
        page: page,
        products: this.searchedProducts,
        selectedCategoryId: this.categoryId,
        searchProductName: this.searchProductName,
      ));
    } else if (event is SingleProductUpdate) {
      print(
          "_______________++++++++++++++++++++++++Sigle Prodcut update method invocked");
      List<Data> cart_product = state.products;

      // for (int i = 0; i < cart_product.length; i++) {
      //   if (cart_product[i] == cart_product[i]) {
      //     cart_product[i] = cart_product[i];
      //   }
      // }
      Data product = event.singleProduct;
      for (int i = 0; i < cart_product.length; i++) {
        print("State Id: ${cart_product[i].id}");
        print("Incomming Product Id: ${product.id}");
        if (product.id!.compareTo(cart_product[i].id as int) == 0) {
          print("+++++++++++Product existed in the cart list");
          cart_product[i].order = product.order;
        }
      }
      yield ProductLoadSuccess(
        products: cart_product,
        selectedCategoryId: state.selectedCategoryId,
        page: state.page,
      );
    } else if (event is LazyFetchProduct) {
      print("page number:${page}");
      try {
        // page++;
        if (!connected) {
          print("bloc--fetch--lazy--1");

          List<Data>? products = await CsvDatabse.instance.readProducts(null);
          if (products == null || products == []) {
            print("bloc--fetch--lazy--2");

            yield ProductOperationFailure(
              message: "Failed to fetch products",
              page: page,
              products: state.products,
              selectedCategoryId: state.selectedCategoryId,
            );
          } else {
            print("bloc--fetch--lazy--3");

            productList = products;
            yield ProductLoadSuccess(
              products: productList,
              selectedCategoryId: state.selectedCategoryId,
              page: page,
            );
          }
          return;
        }
        print("bloc--fetch--lazy--4");

        page++;
        // print("Selected Cat Id:${state.selectedCategoryId}");
        List<Data> products = await this
            .productRepository
            .getProducts(page, state.selectedCategoryId);

        // print("This is the data that come from the repository $products");
        // ignore: unnecessary_null_comparison
        print("Fetched products : ${products}");
        if (products.length == 0) {
          page--;
          print("bloc--fetch--lazy--5");

          // yared coment
          // yield ProductOperationFailure(
          //   message: "Failed to fetch products",
          //   page: page,
          //   products: state.products,
          //   selectedCategoryId: state.selectedCategoryId,
          // );
          yield ProductLoadSuccess(
            products: productList,
            // products: this.categoryId != null
            //     ? this.selectedCategories
            //     : this.productList,
            selectedCategoryId: state.selectedCategoryId,
            page: page,
          );
        } else {
          // List<Data> paginated_products = state.products;
          print("This is the state products.${productList}");
          // print("Page number: $page , category Id : ");

          // for (int i = 0; i < products.length; i++) {
          //   if (paginated_products.contains(products[i])) {
          //   } else {
          //     paginated_products.add(products[i]);
          //   }
          // }
          ///-------alefew comment it-----------
          for (int i = 0; i < products.length; i++) {
            if (productList.contains(products[i])) {
            } else {
              if (this.categoryId != null) {
                this.selectedCategories.add(products[i]);
              } else {
                productList.add(products[i]);
              }
            }
          }
          print("bloc--fetch--lazy--6");

          products.forEach((product) async {
            await CsvDatabse.instance.createProduct(product);
          });
          print("bloc--fetch--lazy--7");
// <<<<<<< yared comment
          // List<Data>? productsFetched =
          //     await CsvDatabse.instance.readProducts(this.categoryId);
          // print("bloc--fetch--lazy--8");

          // if (productsFetched != null) {
          //   if (this.categoryId != null) {
          //     print("bloc--fetch--lazy--9");

          //     selectedCategories = productsFetched;
          //   } else {
          //     print("bloc--fetch--lazy--10");

          //     productList = productsFetched;
          //   }
          // }

          yield ProductLoadSuccess(
            products: productList,
            // products: this.categoryId != null
            //     ? this.selectedCategories
            //     : this.productList,
            selectedCategoryId: state.selectedCategoryId,
            page: page,
          );
          print("Finished yielding");
          // print(productList[0].firstPageUrl);
        }
      } catch (e) {
        print("lazy--loading--failed");
        print(e.toString());
      }
    }
  }
}
