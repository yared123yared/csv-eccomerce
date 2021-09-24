import 'dart:async';

import 'package:app/models/cart-attributes.dart';
import 'package:app/models/product/attributes.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/models/request/request.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
  List<Data> cart_product = [];
  List<CartAttribute> attribtues = [];

  Function eq = const ListEquality().equals;

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // print("Entered to the cart bloc emthod");
    // TODO: implement mapEventToState
    if (event is AddProduct) {
      print(
          "______START______State of the Attributes: ${attribtues.map((e) => e.attributes)}");
      print(
          "____START______New Comming Attributes: ${event.singleProduct.selectedAttributes!.map((e) => e.pivot!.id)}");
      // List<Data> cart_product = state.cartProducts;
      if (cart_product.length == 0) {
        print("initialy the cart was empty");
        Data product = event.singleProduct;
        // product.order += 1;
        cart_product.add(product);
        // assume that the attributes is also 0;
        List<int> attributes_value = [];
        attributes_value.addAll(event.singleProduct.selectedAttributes!
            .map((e) => e.pivot!.id as int));
        attribtues.add(CartAttribute(
            attributes: attributes_value,
            productId: event.singleProduct.id as int));

        print(
            "______UPDATE______State of the Attributes: ${cart_product.map((e) => e.selectedAttributes!.map((e) => e.pivot!.id))}");

        yield CartState(counter: state.counter + 1, cartProducts: cart_product);
        print(
            "______UPDATE 2______State of the Attributes: ${state.cartProducts.map((e) => e.selectedAttributes!.map((e) => e.pivot!.id))}");
      } else {
        // assume that the attributes also have value inside.
        List<int> attributes_value = [];
        attributes_value.addAll(event.singleProduct.selectedAttributes!
            .map((e) => e.pivot!.id as int));
        //
        for (int i = 0; i < attribtues.length; i++) {
          if (event.singleProduct.id!.compareTo(attribtues[i].productId) == 0) {
            if (eq(attributes_value, attribtues[i].attributes)) {
              print("++++++++______Matched_____+++");
              if (event.increment == true) {
                cart_product[i].order += 1;
              } 

              yield CartState(
                  counter: state.counter, cartProducts: cart_product);
              return;
            }
          }
        }

        print("Cart Product Length: ${cart_product.length}");

        attribtues.add(CartAttribute(
            attributes: attributes_value,
            productId: event.singleProduct.id as int));

        cart_product.map((e) => print("Cart Product ${e.id}"));
        // deep copy of an object
        // Map clonedObject = JSON.decode(JSON.encode(object));
        Data product = event.singleProduct;
        cart_product.add(product);
        print("adding new product to cart");
        yield CartState(counter: state.counter + 1, cartProducts: cart_product);

        print("Add Product is called");
        print(
            "_______END____State of the Attributes: ${state.cartProducts.map((e) => e.selectedAttributes!.map((e) => e.pivot!.id))}");
        print(
            "___END______New Comming Attributes: ${event.singleProduct.selectedAttributes!.map((e) => e.pivot!.id)}");
      }
    } else if (event is logEvent) {
      print(
          "STATE VALUE IS THE FOLLOWING. ++++++ ${cart_product.map((e) => e.attributes!.map((e) => e.pivot!.id))}");
    } else if (event is RemoveProduct) {
      state.cartProducts.remove(event.singleProduct);
      yield CartState(
          counter: state.counter - 1, cartProducts: state.cartProducts);
    } else if (event is InitializeCart) {
      attribtues = [];
      cart_product = [];
      yield CartState(counter: 0, cartProducts: []);
    }
  }
}
