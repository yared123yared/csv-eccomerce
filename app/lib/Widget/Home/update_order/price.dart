import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final String? productPrice;
  ProductPrice({required this.productPrice});
  @override
  Widget build(BuildContext context) {
    return Text(
      "\$${productPrice}",
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
