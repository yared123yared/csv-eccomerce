import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  Data product;
  final VoidCallback onTapped;
  AddProductButton({required this.product, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: this.onTapped,
        child: CircleAvatar(
            radius: 10,
            foregroundColor: Colors.black,
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.add,
              size: 16,
            )),
      ),
    );
  }
}
