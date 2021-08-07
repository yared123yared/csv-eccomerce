import 'package:flutter/material.dart';

class EmailOtpSentText extends StatelessWidget {
  final String text;
  EmailOtpSentText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        // fontFamily: 'Raleway',
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
