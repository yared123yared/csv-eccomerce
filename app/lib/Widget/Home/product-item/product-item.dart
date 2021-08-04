import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String image;
  ProductItem({required this.name, required this.image});
  @override
  Widget build(BuildContext context) {
    String image = 'https://csv.jithvar.com/storage/${this.image}';

    print(image);
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
                child: Image.network(
                  image,
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
                        Text(this.name,
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
