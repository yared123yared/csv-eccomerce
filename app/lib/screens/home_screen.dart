<<<<<<< HEAD
import 'package:app/Widget/Auth/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Auth/Home/product-category/productCategory.dart';
import 'package:app/Widget/Auth/Home/search-bar/searchBar.dart';
=======
import 'package:app/models/login_info.dart';
>>>>>>> a1286a462360b00fd091751a701a3620b3bed1e8
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import '../constants/constants.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatelessWidget {
  static const routeName = 'home';

  const Home({Key? key }) : super(key: key);

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
        bottomNavigationBar: HomeBottomNavigation(),
        body: Container(
            color: Color(0xFFf2f6f9),
            child: Column(children: [
              SearchBar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCategory(title: "All"),
                      ProductCategory(
                        title: "Shoes",
                      ),
                      ProductCategory(title: "Phone"),
                      ProductCategory(title: "Chair"),
                      ProductCategory(title: "Watch"),
                      ProductCategory(title: "All"),
                      ProductCategory(
                        title: "Shoes",
                      ),
                      ProductCategory(title: "Phone"),
                      ProductCategory(title: "Chair"),
                      ProductCategory(title: "Watch"),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
