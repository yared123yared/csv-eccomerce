import 'package:flutter/material.dart';
import 'profile_screen.dart';
import '../constants/constants.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
    );
  }
}
