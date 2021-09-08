// import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
// import 'package:app/logic/cart_logic.dart';
// import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class UpdateProductPriceInfo extends StatefulWidget {
  // final List<Data> products;
  double price;
  UpdateProductPriceInfo({required this.price});

  @override
  _UpdateProductPriceInfoState createState() => _UpdateProductPriceInfoState();
}

class _UpdateProductPriceInfoState extends State<UpdateProductPriceInfo> {
  @override
  Widget build(BuildContext context) {
    // CartLogic cartLogic = new CartLogic(products: this.products);
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // height: MediaQuery.of(context).size.height * 0.42,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //   color: Theme.of(context).primaryColor,

          //     borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(20),
          //     topRight: Radius.circular(20),

          //   )),
          //   height: 35,
          //   child: Center(
          //     child: Text(
          //       'Payment Details',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          //   width: double.infinity,
          // ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 10),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        "${widget.price}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax(10%)"),
                      AutoSizeText(
                        "\$20",
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        "\$${widget.price + 20}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Checkout()
        ],
      ),
    );
  }
}
