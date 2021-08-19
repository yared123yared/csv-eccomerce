import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/request.dart';
import 'package:app/screens/cart_screens/add_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onPressed;

  NextButton({required this.onPressed});

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  late OrdersBloc ordersBloc;
  bool nextChecked = false;

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
              child: Text(this.nextChecked == false ? "Next" : "Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          onTap: () {
            widget.onPressed();
            setState(() {
              this.nextChecked = true;
            });
            // ordersBloc.add(CreateOrderEvent(request: null));
            // Navigator.pop(context);
            // Navigator.pushNamed(context, AddClient.routeName);
          }),
    );
  }
}
