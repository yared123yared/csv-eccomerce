import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Checkout extends StatelessWidget {
  // late CartBloc cartBloc;
  // List<Data> products;
  // Checkout({required this.products});
  @override
  Widget build(BuildContext context) {
    // cartBloc = BlocProvider.of<CartBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text("Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          onTap: () {
            // cartBloc.add(AddProduct(singleProduct: this.product));
            Navigator.pop(context);
          }),
    );
  }
}
