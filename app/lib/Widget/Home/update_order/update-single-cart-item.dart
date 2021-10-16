// import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'dart:convert';

import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Home/cart/image.dart';
import 'package:app/Widget/Home/cart/minimize-button.dart';
import 'package:app/Widget/Home/cart/price.dart';
import 'package:app/Widget/Home/cart/remove-cart.dart';
import 'package:app/Widget/Home/cart/sub-title.dart';
import 'package:app/Widget/Home/cart/title.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/cart.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add-button.dart';
import 'amount.dart';

class UpdateSingleCartItem extends StatefulWidget {
  // final Data product;
  final Function increasePrice;
  final Function decreasePrice;
  final Function remove;
  // int cartID;
  // int quantity;
  // double total;
  // double price;
  final OrderToBeUpdated order;
  UpdateSingleCartItem({
    required this.increasePrice,
    required this.decreasePrice,
    required this.remove,
    // required this.product,
    // required this.cartID,
    // required this.price,
    // required this.quantity,
    // required this.total,
    required this.order,
  });

  @override
  _UpdateSingleCartItemState createState() => _UpdateSingleCartItemState();
}

class _UpdateSingleCartItemState extends State<UpdateSingleCartItem> {
  late CartBloc cartBloc;
  late OrdersBloc orderBloc;

  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    orderBloc = BlocProvider.of<OrdersBloc>(context);
    String image = "";
    String productCategory = "";
    if (widget.order.data.photos != null) {
      if (widget.order.data.photos!.length > 0) {
        if (widget.order.data.photos![0].filePath != null) {
          image =
              'https://csv.jithvar.com/storage/${widget.order.data.photos![0].filePath}';
        }
      }
    }
    if (widget.order.data.attributes != null) {
      if (widget.order.data.attributes!.length > 0) {
        productCategory = widget.order.data.name ?? "unknown product";
      }
    }
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
                      ProductTitle(name: this.widget.order.data.name),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      // Text("${product.name}"),

                      ProductCategory(
                        productCategory: productCategory,
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      ProductPrice(productPrice: widget.order.price.toString()),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0001),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            DecreaseProduct(
                              product: widget.order.data,
                              onTapped: this.decrement,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            ProductAmount(
                              amount: widget.order.quantity,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            AddProductButton(
                              onTapped: this.increment,
                              product: widget.order.data,
                            ),
                          ]),
                          RemoveItemFromCart(
                            product: widget.order.data,
                            onTapped: this.removeItem,
                          ),
                        ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      int old = widget.order.quantity;
      ++old;
      widget.order.quantity = old;
      orderBloc.add(
        AddToCart(
          cart: CartItem(
            productId: widget.order.data.id,
            quantity: widget.order.quantity,
            id: widget.order.cartId,
          ),
        ),
      );
      widget.increasePrice(widget.order.price);
    });
  }

  void decrement() {
    setState(() {
      if (widget.order.quantity > 0) {
        int old = widget.order.quantity;
        --old;
        widget.order.quantity = old;
        orderBloc.add(
          DecreaseAmountInCart(
            cart: CartItem(
                productId: widget.order.data.id,
                quantity: 0,
                id: widget.order.cartId),
          ),
        );
        widget.decreasePrice(widget.order.price);
      }
    });
  }

  void removeItem() {
    orderBloc.add(
      RemoveFromCart(
        cart: CartItem(
            productId: widget.order.data.id,
            quantity: widget.order.quantity,
            id: widget.order.cartId),
      ),
    );
    double itemPrice = widget.order.price * widget.order.quantity;
    widget.remove(widget.order, itemPrice);
    // cartBloc.add(RemoveProduct(singleProduct: widget.product));
    // setState(() {
    //   widget.product.quantity = 0;
    // });
  }
}
