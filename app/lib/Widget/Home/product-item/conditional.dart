import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class Conditional extends StatelessWidget {
  final int value;
  final String image;
  final String name;
  final Data product;
  Conditional(
      {required this.name,
      required this.value,
      required this.image,
      required this.product});

  @override
  Widget build(BuildContext context) {
    return this.value != '0'
        ? Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                        // alignment: Alignment.topRight,
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "${this.value}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(
                    (15),
                  ),
                ),
                child: Image.network(image,
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: double.infinity,
                    fit: BoxFit.fill),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                // alignment: Alignment.bottomLeft,
                child: Container(
                  // padding: EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetail.routeName,
                              arguments: this.product);
                        },
                        child: Container(
                          child: Text(this.name,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Text(
                        '\$${this.product.price}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.013,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(
                    (15),
                  ),
                ),
                child: Image.network(image,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.fill),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                // alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(this.name,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.017,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Text(
                          '\$100.00',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
