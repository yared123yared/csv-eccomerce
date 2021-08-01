import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  late final String title;

  SplashScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Welcome To Csv',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: loginSize.getFontSize1,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: loginSize.getHeight * 0.06,
              ),
              Center(
                child: Text(
                  "CSV",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: loginSize.getFontSize1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: loginSize.getHeight * 0.1,
              ),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   child: Text(
              //     this.title,
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
