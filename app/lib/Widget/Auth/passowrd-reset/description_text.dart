import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  DescriptionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        // fontFamily: 'Raleway',
        color: Colors.black,
      ),
    );
  }
}
