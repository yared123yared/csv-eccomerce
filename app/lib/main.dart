import 'package:app/screens/product_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF015777),
        // primaryColor: Color.fromRGBO(146, 40, 105, 1),
        accentColor: Color(0xFFF2F6F9),
        // accentColor: Color(0xFFf2f6f9),
        canvasColor: Color.fromRGBO(225, 254, 229, 1),
        errorColor: Colors.redAccent,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(255, 231, 255, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 31, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      home: ProdutSearch(),
    );
  }
}
