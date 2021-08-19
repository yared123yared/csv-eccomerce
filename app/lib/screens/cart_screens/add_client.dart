import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/cart/add-client/Price-info.dart';
import 'package:app/Widget/Home/cart/add-client/next-button.dart';
import 'package:app/Widget/Home/cart/add-client/upper-container.dart';
import 'package:app/Widget/Home/cart/checkout-button.dart';
import 'package:app/Widget/Home/cart/payment/payment-container.dart';
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
    ScrollController _scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(title: Text("Add Client")),
        // bottomNavigationBar: ,
        backgroundColor: Theme.of(context).accentColor,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.82,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    UpperContainer(),
                    //
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return ClientInfo(
                            products: state.cartProducts,
                          );
                        },
                      ),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       _scrollController.animateTo(
                    //           _scrollController.position.maxScrollExtent,
                    //           duration: Duration(milliseconds: 500),
                    //           curve: Curves.ease);
                    //     },
                    //     child: Text("test")),

                    PaymentContainer()

                    // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                ),
              ),
            ),
            NextButton(
              onPressed: () {
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            )
          ],
        ));
  }

  // bottomNavigationBar: HomeBottomNavigation(),
}
