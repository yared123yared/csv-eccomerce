import 'package:flutter/material.dart';

class CustomCategory extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color fontColor;

  CustomCategory(
      {required this.text,
      required this.onPressed,
      required this.backgroundColor,
      required this.fontColor});
  @override
  _CustomCategoryState createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  Color _color = Color(0xFF015777).withOpacity(0.05);
  Color _fontColor = Colors.black.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    // this._color = Theme.of(context).primaryColor.withOpacity(0.07);
    return GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              // width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.035,
              child: Center(
                child: Text(
                  widget.text,
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: this.widget.fontColor),
                ),
              )),
        ));
  }
}
