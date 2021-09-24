// import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/cart/image.dart';
import 'package:app/Widget/Home/cart/minimize-button.dart';
import 'package:app/Widget/Home/cart/price.dart';
import 'package:app/Widget/Home/cart/remove-cart.dart';
import 'package:app/Widget/Home/cart/sub-title.dart';
import 'package:app/Widget/Home/cart/title.dart';
import 'package:app/models/product/data.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add-button.dart';
import 'amount.dart';

class SingleCartItem extends StatefulWidget {
  final Data product;
  SingleCartItem({required this.product});

  @override
  _SingleCartItemState createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  late CartBloc cartBloc;
  late ProductBloc productBloc;
  @override
  Widget build(BuildContext context) {
    print("Single cart product have been called");
    cartBloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    String image = "";
    if (widget.product.photos != null) {
      image =
          'https://csv.jithvar.com/storage/${widget.product.photos![0].filePath.toString()}';
    }
    print("________Arrived on the padding");
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
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
            child: Row(
              children: [
                LeadingImage(image: image),
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
                        ProductTitle(name: this.widget.product.name),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        // Text("${product.name}"),
                        ProductCategory(
                          productCategory:
                              widget.product.categories!.length != 0
                                  ? widget.product.categories![0].name
                                  : "",
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        ProductPrice(productPrice: widget.product.price),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0001),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              DecreaseProduct(
                                product: widget.product,
                                onTapped: this.decrement,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              ProductAmount(
                                amount: widget.product.order,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              AddProductButton(
                                onTapped: this.increment,
                                product: widget.product,
                              ),
                            ]),
                            RemoveItemFromCart(
                              product: widget.product,
                              onTapped: this.removeItem,
                            ),
                          ]),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void increment() {
    setState(() {
      widget.product.order++;
    });
    productBloc.add(SingleProductUpdate(singleProduct: widget.product, increment:true));
    cartBloc.add(AddProduct(singleProduct: widget.product, increment: null));
  }

  void decrement() {
    setState(() {
      widget.product.order--;
    });
    productBloc.add(SingleProductUpdate(singleProduct: widget.product, increment: false));
    cartBloc.add(AddProduct(singleProduct: widget.product, increment: null));
  }

  void removeItem() {
    Data product = widget.product;
    // product.order = 0;
    productBloc.add(SingleProductUpdate(singleProduct: product, increment:null));
    cartBloc.add(RemoveProduct(singleProduct: widget.product));
    // setState(() {
    //   widget.product.order = 0;
    // });
  }
}
