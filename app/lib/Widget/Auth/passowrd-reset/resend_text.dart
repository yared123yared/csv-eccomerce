import 'package:flutter/material.dart';

class ResendText extends StatelessWidget {
  final String text;
  final Function onTap;
  ResendText({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap(),
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          // fontFamily: 'Raleway',
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
