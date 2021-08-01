import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Container(
        padding: EdgeInsets.only(top: 55),
        width: double.infinity,
        // color: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        child: Column(children: [
          Text(
            'Welcome To Csv',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: loginSize.getFontSize1,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: loginSize.getHeight * 0.02,
          ),
          Container(
              // color: Colors.transparent,
              child: new Image.asset(
            'assets/images/login/csv_img.png',
            height: loginSize.getWelcomeHeight,
            width: loginSize.getWelcomeWidth,
            fit: BoxFit.fill,
          )),
          SizedBox(
            height: loginSize.getHeight * 0.05,
          ),
        ]));
  }
}
