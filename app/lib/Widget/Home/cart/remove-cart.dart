import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';

class RemoveItemFromCart extends StatelessWidget {
  final Data product;
  final VoidCallback onTapped;
  RemoveItemFromCart({required this.product, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: this.onTapped,
        child: CircleAvatar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey,
          radius: 13,
          child: Icon(
            Icons.delete,
            size: MediaQuery.of(context).size.width * 0.035,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
