import 'package:flutter/material.dart';

import 'badge.dart';

class HomeBottomNavigation extends StatefulWidget {
  @override
  _HomeBottomNavigationState createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Image.asset(
                'assets/icons/home.png',
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Image.asset(
                'assets/icons/categories.png',
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
          ),
          // Expanded(child: new Text('')),
          Expanded(
            child: IconButton(
              icon: Image.asset(
                'assets/icons/cart2.png',
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Image.asset(
                'assets/icons/um2.png',
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
