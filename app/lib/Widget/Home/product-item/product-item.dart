import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String image =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg';
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.7,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 1,
          margin: EdgeInsets.all(10),
          child: Column(
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
                child: Image.asset(
                  "assets/images/16.jpg",
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
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
                        Text('Nike Shoes New',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.017,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
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
          ),
        ),
      ),
    );
  }
}
