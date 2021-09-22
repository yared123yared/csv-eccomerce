import 'package:app/Widget/Home/product-detail/add-cart-button.dart';
import 'package:app/Widget/Home/product-detail/color-container.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:app/Widget/Home/product-detail/detail-container.dart';
import 'package:app/Widget/Home/product-detail/product-info.dart';
import 'package:app/models/product/attributes.dart';

import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/product/details';
  final Data products;
  final VoidCallback onClicked;

  ProductDetail({required this.products, required this.onClicked});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Attributes? selectedColor = null;
  // Data product = convert() as Data;
  // Future<Data> convert() async {
  //   return await Data.copyWith(product);
  // }

  void changeSelectedColor(Attributes color, Data product) {
    setState(() {
      selectedColor = color;
    });
    int counter = 0;
    for (int i = 0; i < product.selectedAttributes!.length; i++) {
      if (product.selectedAttributes![i].name!.contains("Color")) {
        print("Size attribute already selected.");

        // products.selectedAttributes!
        //     .remove(products.selectedAttributes![i]);
        product.selectedAttributes![i] = selectedColor!;
        counter += 1;
      }
    }
    if (counter == 0) {
      print("First selection of the color attribute");
      product.selectedAttributes!.add(selectedColor!);
    } else {
      print("Updating the attribute");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Arrived at the product detail page detail.");
    Data product = new Data();
    // product.id = widget.products.id;
    product.copyWith(widget.products);
    print("Detail data: ${widget.products.toJson()}");
    print("Converted data: ${product.toJson()}");
//  Data  product = Data.copyWith(product);
    // Data? products = ModalRoute.of(context)!.settings.arguments as Data;
    String image =
        'https://csv.jithvar.com/storage/${product.photos![0].filePath.toString()}';
    List<String> photos = [];
    if (product.photos != []) {
      for (int i = 0; i < product.photos!.length; i++) {
        photos.add(
            'https://csv.jithvar.com/storage/${product.photos![i].filePath.toString()}');
      }
    }

    // check the size here.
    List<String?> size = [];
    List<Attributes> color = [];

    if (product.attributes != null) {
      List<Attributes> attributes = product.attributes as List<Attributes>;

      print("Attributes Size: ${product.attributes![0].name}");
      for (int i = 0; i < product.attributes!.length; i++) {
        print("Attributes: ${product.attributes}");
        print("products.attributes: ${product.attributes![i].name}");
        if (product.attributes![i].name!.contains('Size')) {
          print("Size:  ${product.attributes![i].pivot!.value}");
          size.add(product.attributes![i].pivot!.value);
        }
      }
      // check color

      for (int i = 0; i < product.attributes!.length; i++) {
        List<Attributes> attributes = product.attributes as List<Attributes>;
        if (attributes[i].name!.contains('Color')) {
          // print("Color:  ${attributes[i].pivot!.value}");
          color.add(attributes[i]);
        }
      }
    }
    if (selectedColor == null) {
      selectedColor = color[0];
      //product.selectedAttributes![i] = selectedColor!;

    }
    // Check if the color seelction ahve null value or not.
    int counter = 0;
    for (int i = 0; i < product.selectedAttributes!.length; i++) {
      if (product.selectedAttributes![i].name!.contains("Color")) {
        print("Size attribute already selected.");

        // products.selectedAttributes!
        //     .remove(products.selectedAttributes![i]);
        product.selectedAttributes![i] = selectedColor!;
        counter += 1;
      }
    }
    if (counter == 0) {
      print("First selection of the color attribute");
      product.selectedAttributes!.add(selectedColor!);
    } else {
      print("Updating the attribute");
    }

    print("Adding to the color container");
    List<Widget> colorContainer = [];
    for (int i = 0; i < color.length; i++) {
      print("Color for the widget: ${color}");
      colorContainer.add(ColorContainer(
        color: color[i],
        
        selectedColor: this.selectedColor as Attributes,
        onPressed: this.changeSelectedColor,
      ));
    }
    // ignore: unnecessary_null_comparison

    print("Build is sucessfully finished");
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
                    child: CarouselSlider.builder(
                      itemCount: photos.length,
                      itemBuilder: (context, index, realIndex) => Container(
                        width: double.infinity,
                        child: new Image.network(
                          photos[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.35,
                        aspectRatio: 1,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        // reverse: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      ),
                    )

                    // child: Swiper(
                    // itemBuilder: (BuildContext context, int index) {
                    //   return new Image.network(
                    //     photos[index],
                    //     fit: BoxFit.fill,
                    //   );
                    //   },
                    //   itemCount: photos.length,
                    //   pagination: new SwiperPagination(),
                    //   control: new SwiperControl(),
                    // ),
                    ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: AutoSizeText(
                        "${product.name}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: AutoSizeText(
                    product.categories!.length != 0
                        ? "${product.categories![0].fullName}"
                        : "",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // size.length==0? null:CustomeDropDown(product: products,)),
                      Container(
                          child: size.length == 0
                              ? null
                              : Row(children: [
                                  Text("Size"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                  ),
                                  CustomeDropDown(
                                    product: product,
                                  ),
                                ])),
                      // CustomeDropDown(product: products,),

                      Row(
                        children: [
                          Text("COLOR"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Row(
                            children: colorContainer,
                          )
                        ],
                      ),
                    ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ProductInfo(
                  product: product,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                AddToCart(
                  onTapped: this.widget.onClicked,
                  product: product,
                )
              ],
            ),
          ),
        ));
  }
}
