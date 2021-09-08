import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/request.dart';
import 'package:app/screens/cart_screens/add_client.dart';
import 'package:app/screens/cart_screens/cart_screen.dart';
import 'package:app/screens/category_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Checkout extends StatelessWidget {
  late OrdersBloc ordersBloc;
  // List<Data> products;
  // Checkout({required this.products});
  @override
  Widget build(BuildContext context) {
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text("Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                onTap: () {
                  if (state.cartProducts.length == 0) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'No Item In the Cart',
                      desc: 'Please add some products to the cart!',
                      btnCancelOnPress: () {
                        Navigator.popAndPushNamed(
                            context, MainScreen.routeName);
                      },
                      btnOkOnPress: () {
                        Navigator.popAndPushNamed(
                            context, MainScreen.routeName);
                      },
                    )..show();
                  } else {
                    ordersBloc.add(
                        CartCheckoutEvent(cartProducts: state.cartProducts));
                    Navigator.pushNamed(context, AddClient.routeName);
                  }

                  // Navigator.pop(context);
                });
          },
        ));
  }
}
