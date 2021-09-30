import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/screens/cart_screens/add_client.dart';
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
    final cubit = BlocProvider.of<LanguageCubit>(context);
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
                    child: Text(cubit.tCheckout(),
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
                      title: cubit.tNoItemIntheCart(),
                      desc: cubit.tPleaseaddsomeproductstothecart(),
                      btnCancelOnPress: () {
                        Navigator.popAndPushNamed(
                            context, MainScreen.routeName);
                      },
                      btnOkOnPress: () {
                        Navigator.popAndPushNamed(
                            context, MainScreen.routeName, arguments:1);
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
