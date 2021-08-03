import 'package:flutter/material.dart';

class DidnotRecieveText extends StatelessWidget {
  final String text;
  DidnotRecieveText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        // fontFamily: 'Raleway',
        color: Color(0xFF494949),
      ),
    );
  }
}
