import 'dart:ffi';

import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'conditional.dart';

class ProductItem extends StatefulWidget {
  Data product;
  final VoidCallback onTapped;
  // final VoidCallback onPressed;

  ProductItem({required this.product, required this.onTapped});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    String image =
        'https://csv.jithvar.com/storage/${this.widget.product.photos![0].filePath.toString()}';
    // print(image);
    return InkWell(
        onTap: () {
          setState(() {
            widget.product.order += 1;
          });
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 1,
              margin: EdgeInsets.all(10),
              child: Conditional(
                  name: this.widget.product.name.toString(),
                  image: image,
                  value: this.widget.product.order),
            )));
  }
}
