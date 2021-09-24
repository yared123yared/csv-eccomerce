import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCart extends StatelessWidget {
  late CartBloc cartBloc;
  final VoidCallback onTapped;
  Data product;
  AddToCart({required this.product, required this.onTapped});
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: this.product.order == 0
                ? Text(cubit.tAddtoCart(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ))
                : Text(cubit.tUpdateCart(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
          ),
        ),
        onTap: () {
          this.onTapped();
          Data product = this.product;
          if (product.order == 0) {
            product.order++;
          }
          cartBloc.add(AddProduct(singleProduct: product, increment: true));
          Navigator.pop(context);
        });
  }
}
