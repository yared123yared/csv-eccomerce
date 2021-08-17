import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/request.dart';
import 'package:app/screens/cart_screens/add_client.dart';
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
      child: GestureDetector(
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
            // ordersBloc.add(CreateOrderEvent(request: null));
            // Navigator.pop(context);
            Navigator.pushNamed(context, AddClient.routeName);
          }),
    );
  }
}
