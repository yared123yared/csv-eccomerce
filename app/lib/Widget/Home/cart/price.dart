import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final String? productPrice;
  ProductPrice({required this.productPrice});
  @override
  Widget build(BuildContext context) {
    print("+++++arrived at price widget");
    return Text(
      "\$${productPrice}",
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
