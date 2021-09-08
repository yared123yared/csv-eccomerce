import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/cart/checkout-button.dart';
import 'package:app/Widget/Home/cart/product-price-info.dart';
import 'package:app/Widget/Home/cart/single-cart-item.dart';
import 'package:app/logic/cart_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    CartLogic cartLogic = new CartLogic(products: []);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          print("This is the cart state: ${state.cartProducts}");
          if (state.cartProducts != []) {
            return Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 0,
                        );
                      },
                      itemBuilder: (context, index) =>
                          index >= state.cartProducts.length
                              ? Container(child: Text("The end"))
                              : SingleCartItem(
                                  product: state.cartProducts[index],
                                ),
                      itemCount: state.cartProducts.length,
                    )),
                //
                ProductPriceInfo(
                  products: state.cartProducts,
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            );
          } else {
            return Center(child: Text("No Item in Cart"));
          }
        },
      ),
    );

    // bottomNavigationBar: HomeBottomNavigation(),
  }
}
