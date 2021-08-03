import 'package:app/Widget/product%20search/deleteButton.dart';
import 'package:app/Widget/product%20search/edit_button.dart';
import 'package:app/models/product_data.dart';
import 'package:flutter/material.dart';

import 'product_data_row.dart';

class Product extends StatelessWidget {
  final ProductData product;
  Product({required this.product});
  void deletProduct() {}
  void editProduct() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 215,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              ProductDataRow(property: 'NAME', value: this.product.name),
              ProductDataRow(property: 'MODEL', value: this.product.model),
              ProductDataRow(
                  property: 'PRICE',
                  value: '\$${this.product.price.toStringAsFixed(2)}'),
              ProductDataRow(
                  property: 'QUANTITY', value: '${this.product.quantity}'),
              ProductDataRow(
                  property: 'STATUS', value: '${this.product.status}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EditButton(
                    onPressed: () => editProduct(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DeleteButton(
                    onPressed: () => deletProduct(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
