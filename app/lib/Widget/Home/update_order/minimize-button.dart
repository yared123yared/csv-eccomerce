import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';

class DecreaseProduct extends StatelessWidget {
  Data product;
  final VoidCallback onTapped;
  DecreaseProduct({required this.product, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: this.onTapped,
        child: CircleAvatar(
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).accentColor,
          radius: 10,
          child: Text("-"),
        ),
      ),
    );
  }
}
