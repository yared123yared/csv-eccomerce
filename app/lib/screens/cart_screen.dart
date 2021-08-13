import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/cart/single-cart-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            // return ListTileTheme.merge(
            //     contentPadding: EdgeInsets.all(0.0),
            //     dense: true,
            //     child: ListView.builder(
            //       padding: EdgeInsets.all(0.0),
            //       itemBuilder: (context, index) => SingleCartItem(
            //         product: state.cartProducts[index],
            //       ),
            //       itemCount: state.cartProducts.length,
            //     ));
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 0,
                );
              },
              itemBuilder: (context, index) => SingleCartItem(
                product: state.cartProducts[index],
              ),
              itemCount: state.cartProducts.length,
            );
          },
        ));
    // bottomNavigationBar: HomeBottomNavigation(),
  }
}
