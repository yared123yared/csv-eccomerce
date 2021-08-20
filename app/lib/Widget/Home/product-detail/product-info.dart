import 'package:app/Widget/Home/product-detail/description-container.dart';
import 'package:app/Widget/Home/product-detail/detail-container.dart';
import 'package:app/Widget/Home/product-detail/select_option.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatefulWidget {
  final Data product;
  ProductInfo({required this.product});

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int isDescriptionChecked = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 1,
      color: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   // shape:
        // ),
        child: Column(children: [
          SelectOption(
            onPressed: this.changeState,
            state: this.isDescriptionChecked,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          this.isDescriptionChecked == 0
              ? ProductDescription(product: widget.product)
              : DetailContainer(product: widget.product)
        ]),
      ),
    );
  }

  void changeState(int state) {
    setState(() {
      this.isDescriptionChecked = state;
    });
  }
}
