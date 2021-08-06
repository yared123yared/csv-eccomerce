import 'dart:async';

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
      print("Add Product is called");
      yield CartState(counter: state.counter + 1);
    }
  }
}
