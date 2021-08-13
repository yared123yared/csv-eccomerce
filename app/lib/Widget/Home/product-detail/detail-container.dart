import 'package:app/Widget/Home/product-detail/select_option.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DetailContainer extends StatelessWidget {
  final Data product;
  DetailContainer({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 1,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   // shape:
        // ),
        child: Column(
          children: [
            SelectOption(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  "PRICE",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  "Model",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: AutoSizeText(
                    "${product.model}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                    maxLines: 2,
                  ),
                ),
                // Text(
                //   "${product.model}",
                //   style: TextStyle(
                //       fontSize: 16,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w300),
                // ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  "SKU",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text(
                  "12",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
