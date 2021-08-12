import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';

class SingleCartItem extends StatelessWidget {
  final Data product;
  SingleCartItem({required this.product});
  @override
  Widget build(BuildContext context) {
    String image =
        'https://csv.jithvar.com/storage/${product.photos![0].filePath.toString()}';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 1,
          color: Colors.white,
          child: Container(
            // margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            // width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.17,
            // padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
            child: Row(
              children: [
                Image.network(
                  image,
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.3,
                )
              ],
            ),
          )),
    );
  }
}
