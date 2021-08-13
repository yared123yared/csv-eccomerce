import 'dart:async';

import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    print("Entered to the cart bloc emthod");
    // TODO: implement mapEventToState
    if (event is AddProduct) {
      List<Data> cart_product = state.cartProducts;
      if (cart_product.contains(event.singleProduct)) {
        yield CartState(counter: state.counter, cartProducts: cart_product);
      } else {
        cart_product.add(event.singleProduct);
        yield CartState(counter: state.counter + 1, cartProducts: cart_product);
      }

      print("Add Product is called");
    } else if (event is RemoveProduct) {
      state.cartProducts.remove(event.singleProduct);
      yield CartState(
          counter: state.counter - 1, cartProducts: state.cartProducts);
    }
  }
}
