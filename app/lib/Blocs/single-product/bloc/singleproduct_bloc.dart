import 'dart:async';

import 'package:app/models/product/data.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'singleproduct_event.dart';
part 'singleproduct_state.dart';

class SingleproductBloc extends Bloc<SingleproductEvent, SingleproductState> {
  late Data products;
  SingleproductBloc() : super(SingleproductState(products: new Data()));
  @override
  Stream<SingleproductState> mapEventToState(
    SingleproductEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AddProduct) {
      print("Add product is called");
      Data products = state.products;
      products.order += 1;
      yield SingleproductState(products: products);
    } else if (event is Initial) {
      // state.products = Initial.products;
      // print("Called for the first time");
      Data products = event.products;
      yield SingleproductState(products: products);
    }
  }
}
