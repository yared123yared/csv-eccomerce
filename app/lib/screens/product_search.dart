import 'package:app/Widget/product%20search/product.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/product_data.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ProdutSearch extends StatefulWidget {
  const ProdutSearch({Key? key}) : super(key: key);

  @override
  _ProdutSearchState createState() => _ProdutSearchState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ProdutSearchState extends State<ProdutSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('CSV'),
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          child: Container(
            height: 5.0,
            width: 5.0,
            child: ImageIcon(
              AssetImage('assets/images/left-align.png'),
            ),
          ),
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              primaryColor, //This will change the drawer background to blue.
          //other styles
        ),
        child: Profile(),
      ),
      drawerEnableOpenDragGesture: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Product(
            product: ProductData(
                name: 'Apple',
                model: 'Iphone12',
                price: 450,
                quantity: 45,
                status: 'ACTIVE'),
          ),
          Product(
            product: ProductData(
              name: 'Apple',
              model: 'Iphone12',
              price: 450,
              quantity: 45,
              status: 'ACTIVE',
            ),
          ),
        ],
      ),
    );
    ;
  }
}
