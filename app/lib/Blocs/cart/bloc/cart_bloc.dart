import 'dart:async';

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

  Function eq = const ListEquality().equals;

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // print("Entered to the cart bloc emthod");
    // TODO: implement mapEventToState
    if (event is AddProduct) {
      print(
          "State of the Attributes: ${state.cartProducts.map((e) => e.selectedAttributes!.map((e) => e.pivot!.id))}");
      print(
          "New Comming Attributes: ${event.singleProduct.selectedAttributes!.map((e) => e.pivot!.id)}");
      List<Data> cart_product = state.cartProducts;
      if (cart_product.length == 0) {
        cart_product.add(event.singleProduct);
        yield CartState(counter: state.counter + 1, cartProducts: cart_product);
      } else {
        List<Attributes>? eventSelectedAttributes =
            event.singleProduct.selectedAttributes;

        List<int> eventSelectedIntAttributes = [];

        for (int i = 0; i < eventSelectedAttributes!.length; i++) {
          eventSelectedIntAttributes
              .add(eventSelectedAttributes[i].pivot!.id as int);
        }
        print("Cart Product Length: ${cart_product.length}");

        for (int i = 0; i < cart_product.length; i++) {
          List<Attributes>? selectedAttributes =
              cart_product[i].selectedAttributes;

          List<int> selectedIntAttributes = [];
          for (int i = 0; i < selectedAttributes!.length; i++) {
            selectedIntAttributes.add(selectedAttributes[i].pivot!.id as int);
          }

          print("New Event Attributes: ${eventSelectedIntAttributes}");
          print("Cart Item of $i attributes: ${selectedIntAttributes}");
          if (eq(eventSelectedIntAttributes, selectedIntAttributes)) {
            print("++++++++______Matched_____+++");
            yield CartState(counter: state.counter, cartProducts: cart_product);
            return;
          } else {}
          // print("Entered to the for loop");
          // if (DeepCollectionEquality()
          //     .equals(cart_product[i].toJson(), event.singleProduct.toJson())) {
          //   print("++++++++++++++++++++++++Matched");
          //   yield CartState(counter: state.counter, cartProducts: cart_product);
          //   return;
          // } else {
          //   print("+++++++++++++++This didn't mateched");
          //   cart_product.add(event.singleProduct);

          // }
          // if(cart_product[i].equals(event.singleProduct))
        }
        cart_product.map((e) => print("Cart Product ${e.id}"));
        // deep copy of an object 
        // Map clonedObject = JSON.decode(JSON.encode(object));
        Data product = event.singleProduct;
        cart_product.add(product);
        print("adding new product to cart");
        yield CartState(counter: state.counter + 1, cartProducts: cart_product);

        // yield CartState(counter: state.counter + 1, cartProducts: cart_product);
        // if (cart_product.contains(event.singleProduct)) {
        //   // cart already contains an object.
        //   yield CartState(counter: state.counter, cartProducts: cart_product);
        // } else {
        //   cart_product.add(event.singleProduct);
        //   yield CartState(counter: state.counter + 1, cartProducts: cart_product);
        // }

        print("Add Product is called");
        
      }
    } else if (event is RemoveProduct) {
      state.cartProducts.remove(event.singleProduct);
      yield CartState(
          counter: state.counter - 1, cartProducts: state.cartProducts);
    } else if (event is InitializeCart) {
      yield CartState(counter: 0, cartProducts: []);
    }
  }
}
