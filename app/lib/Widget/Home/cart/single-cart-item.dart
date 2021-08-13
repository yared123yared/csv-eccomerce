import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        image,
                      ),
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: AutoSizeText(
                            "${this.product.name}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        // Text("${product.name}"),
                        Text(
                          "${product.categories![0].name}",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          "\$${product.price}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0001),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            // width: MediaQuery.of(context).size.width * 0.07,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor,
                            ),
                            child: Center(
                              child: IconButton(
                                alignment: Alignment.center,
                                icon: Icon(Icons.minimize),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Text("2"),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ]),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.166,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () {},
                              icon: Icon(Icons.delete,
                                  size:
                                      MediaQuery.of(context).size.width * 0.035,
                                  color: Colors.white.withOpacity(0.8))),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
