import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/cart/add-client/Price-info.dart';
import 'package:app/Widget/Home/cart/add-client/upper-container.dart';
import 'package:app/Widget/Home/cart/checkout-button.dart';
import 'package:app/Widget/Home/cart/product-price-info.dart';
import 'package:app/Widget/Home/cart/single-cart-item.dart';
import 'package:app/logic/cart_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddClient extends StatelessWidget {
  static const routeName = '/cart/add-client';
  @override
  Widget build(BuildContext context) {
    CartLogic cartLogic = new CartLogic(products: []);
    return Scaffold(
        appBar: AppBar(title: Text("Add Client")),
        // bottomNavigationBar: ,
        backgroundColor: Theme.of(context).accentColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              UpperContainer(),
              //
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ClientInfo(
                    products: state.cartProducts,
                  );
                },
              )
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ));
  }

  // bottomNavigationBar: HomeBottomNavigation(),
}
