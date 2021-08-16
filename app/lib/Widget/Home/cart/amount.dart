import 'package:flutter/material.dart';

class ProductAmount extends StatelessWidget {
  final int amount;
  ProductAmount({required this.amount});
  @override
  Widget build(BuildContext context) {
    return Text("$amount");
  }
}
