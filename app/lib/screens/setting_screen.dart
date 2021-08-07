import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Text("Setting Screen"),
      ),
      // bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}
