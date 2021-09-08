import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final String productCategory;
  ProductCategory({required this.productCategory});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${productCategory}",
      style: TextStyle(fontWeight: FontWeight.w300),
    );
  }
}
