import 'dart:ffi';

import 'package:app/Blocs/single-product/bloc/singleproduct_bloc.dart';
import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'conditional.dart';

class ProductItem extends StatelessWidget {
  Data product;
  final VoidCallback onTapped;
  // final VoidCallback onPressed;
  late SingleproductBloc singleproductBloc;

  ProductItem({required this.product, required this.onTapped});
  @override
  Widget build(BuildContext context) {
    String image =
        'https://csv.jithvar.com/storage/${this.product.photos![0].filePath.toString()}';
    // print(image);
    return InkWell(
        onTap: this.onTapped,
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
                  name: this.product.name.toString(),
                  image: image,
                  value: this.product.order),
            )));
  }
}
