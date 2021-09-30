import 'package:app/Widget/Home/product-detail/add-cart-button.dart';
import 'package:app/Widget/Home/product-detail/color-container.dart';
import 'package:app/Widget/Home/product-detail/custome-drop-down.dart';
import 'package:app/Widget/Home/product-detail/detail-container.dart';
import 'package:app/Widget/Home/product-detail/product-info.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/product/attributes.dart';

import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // late Data product;

  void changeSelectedColor(Attributes color, Data product) {
    print(
        "SELECTED ATTRIBUTES ON THE CAHNGEsELECEDCOLRO:  ${product.selectedAttributes!.map((e) => e.pivot!.value)}");
    // print("this is the producvt id: ${product.id}");
    print("++++++++++++++++__________Selcted Color: ${color.pivot!.id}");
    setState(() {
      selectedColor = color;
    });
    print(
        "SELECTED ATTRIBUTES ON THE CAHNGEsELECEDCOLRO:  ${product.selectedAttributes!.map((e) => e.pivot!.value)}");
    // int counter = 0;
    // for (int i = 0; i < product.selectedAttributes!.length; i++) {
    //   if (product.selectedAttributes![i].name!.contains("Color")) {
    //     print("Color attribute already selected.");

    //     // products.selectedAttributes!
    //     //     .remove(products.selectedAttributes![i]);
    //     // product.selectedAttributes![i] = dropdownValue!;
    //     product.selectedAttributes![i] = selectedColor!;
    //     counter += 1;
    //   }
    // }

    // if (counter == 0) {
    //   print("First selection of the color attribute");
    //   product.selectedAttributes!.add(selectedColor!);
    // } else {
    //   print("Updating the attribute");
    // }
  }

  @override
  Widget build(BuildContext context) {
    print("Arrived at the product detail page detail.");
    print(
        "*******+++++++++_____++Selcted attributes that comes form the prodcut category: ${widget.products.selectedAttributes!.map((e) => e.pivot!.id)}");
    Data product = widget.products;
    //  Data product = new Data(
    //     attributes: widget.products.attributes,
    //     categories: widget.products.categories,
    //     currencyId: widget.products.currencyId,
    //     id: widget.products.id,
    //     manufacturerId: widget.products.manufacturerId,
    //     model: widget.products.model,
    //     name: widget.products.name,
    //     photos: widget.products.photos,
    //     price: widget.products.price,
    //     quantity: widget.products.quantity,
    //     status: widget.products.status,
    //     // photos:
    //     // data.photos,
    //     selectedAttributes: widget.products.selectedAttributes!
    //         .map((e) => new Attributes(
    //               companyId: e.companyId,
    //               createdAt: e.createdAt,
    //               id: e.id,
    //               name: e.name,
    //               pivot: e.pivot,
    //               updatedAt: e.updatedAt,
    //             ))
    //         .toList());
    // product.id = widget.products.id;
    // product.copyWith(widget.products);
    // product.selectedAttributes = [];
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
    print("photos parsed well");
    // check the size here.
    List<String?> size = [];
    List<Attributes> color = [];

    if (product.attributes!.length != 0) {
      print("++++++++entered to the attribute selection loop");

      // print("Attributes Size: ${product.attributes![0].name}");
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
    print("+++++++++++++++____Arrived here");
    if (selectedColor == null) {
      if (color.length != 0) {
        selectedColor = color[0];
      }

      //product.selectedAttributes![i] = selectedColor!;

    }
    print("parsing color");
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
      if (color.length != 0) {
        print("First selection of the color attribute");
        product.selectedAttributes!.add(selectedColor!);
      }
    } else {
      print("Updating the attribute");
    }

    print("Adding to the color container");
    List<Widget> colorContainer = [];
    for (int i = 0; i < color.length; i++) {
      print("Color for the widget: ${color}");
      colorContainer.add(ColorContainer(
        product: product,
        color: color[i],
        selectedColor: this.selectedColor as Attributes,
        onPressed: this.changeSelectedColor,
      ));
    }
    // ignore: unnecessary_null_comparison

    print("Build is sucessfully finished");
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(cubit.tProduct(), style: TextStyle()),
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
                        child: CachedNetworkImage(
                          imageUrl: photos[index],
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                            color: Colors.white,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.black,
                            child: Icon(Icons.error),
                          ),
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
                    )),
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
                          Text(cubit.tCOLOR()),
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
