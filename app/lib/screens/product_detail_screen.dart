import 'package:app/Widget/Home/product-detail/add-cart-button.dart';
import 'package:app/Widget/Home/product-detail/color-container.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:app/Widget/Home/product-detail/detail-container.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product/details';
  final Data products;
  ProductDetail({required this.products});
  @override
  Widget build(BuildContext context) {
    // Data? products = ModalRoute.of(context)!.settings.arguments as Data;
    String image =
        'https://csv.jithvar.com/storage/${products.photos![0].filePath.toString()}';
    List<String> photos = [];
    for (int i = 0; i < this.products.photos!.length; i++) {
      photos.add(
          'https://csv.jithvar.com/storage/${products.photos![i].filePath.toString()}');
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Products", style: TextStyle()),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Container(
          // color: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return new Image.network(
                        photos[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: photos.length,
                    pagination: new SwiperPagination(),
                    control: new SwiperControl(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: AutoSizeText(
                        "${this.products.name}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.7,
                    //   // height: MediaQuery.of(context).size.height * 0.1,
                    //   child: AutoSizeText(
                    //     "${this.products.name}",
                    //     // textAlign: TextAlign.justify,
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w600,
                    //         fontStyle: FontStyle.normal),
                    //   ),
                    // ),
                    Text(
                      "\$${this.products.price}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "Shoes > OUTDOOR SHOES",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text("Size"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.09,
                        ),
                        CustomeDropDown(),
                      ]),
                      Row(
                        children: [
                          Text("COLOR"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          ColorContainer(color: Colors.blueAccent),
                          ColorContainer(
                            color: Colors.pinkAccent,
                          ),
                          ColorContainer(
                            color: Colors.purpleAccent,
                          )
                        ],
                      ),
                    ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                DetailContainer(
                  product: this.products,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                AddToCart()
              ],
            ),
          ),
        ));
  }
}
