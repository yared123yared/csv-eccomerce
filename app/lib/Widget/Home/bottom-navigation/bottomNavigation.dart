import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'badge.dart';
import 'cart.dart';

class HomeBottomNavigation extends StatefulWidget {
  @override
  _HomeBottomNavigationState createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  late CartBloc cartBloc;
  int _selectedIndex = 0;
  int check = 0;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);

    return Container(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return BottomAppBar(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Image.asset(
                      'assets/icons/home.png',
                      color: check == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        check = 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Image.asset(
                      'assets/icons/categories.png',
                      color: check == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        check = 1;
                      });
                    },
                  ),
                ),
                // Expanded(child: new Text('')),
                Expanded(
                  child: IconButton(
                    icon: Cart(
                      value: state.counter,
                      check: check,
                    ),
                    onPressed: () {
                      setState(() {
                        check = 2;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Image.asset(
                      'assets/icons/um2.png',
                      color: check == 3
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        check = 3;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // child: BottomAppBar(
      //   child: new Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Image.asset(
      //           'assets/icons/home.png',
      //           color: Colors.grey,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Image.asset(
      //           'assets/icons/categories.png',
      //           color: Theme.of(context).primaryColor,
      //         ),
      //         onPressed: () {},
      //       ),
      //       // Expanded(child: new Text('')),
      //       IconButton(
      //         icon: Cart(
      //           value: 1,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Image.asset(
      //           'assets/icons/um2.png',
      //           color: Colors.grey,
      //         ),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
