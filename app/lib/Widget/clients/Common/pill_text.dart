import 'package:flutter/material.dart';

class PillText extends StatelessWidget {
  final String text;
  final Color fgColor;
  final Color bgColor;
  PillText({
    required this.text,
    required this.bgColor,
    required this.fgColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
          // color: Colors.greenAccent.shade700,
          color:this.bgColor,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        this.text,
        style: TextStyle(
          // color: Colors.white,
          color: this.fgColor,
          fontSize: 16,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
