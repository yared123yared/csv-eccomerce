import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/logic/cart_logic.dart';
import 'package:app/models/product/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientInfo extends StatelessWidget {
  final List<Data> products;

  ClientInfo({required this.products});
  @override
  Widget build(BuildContext context) {
    CartLogic cartLogic = new CartLogic(products: this.products);
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 10),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cubit.tTotaL(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        "\$${cartLogic.getTotalPrice()}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
              //   child: Container(
              //     width: double.infinity,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("Tax(10%)"),
              //         AutoSizeText(
              //           "\$20",
              //           maxLines: 2,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
              //   child: Container(
              //     width: double.infinity,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("Total",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 16)),
              //         Text(
              //           "\$${cartLogic.getTotalPrice() + 20}",
              //           style: TextStyle(fontSize: 15),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
