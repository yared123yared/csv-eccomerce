import 'package:app/Widget/Home/product-detail/select_option.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final Data product;
  ProductDescription({required this.product});

  @override
  Widget build(BuildContext context) {
    return Text("Description comes here");
  }
}
