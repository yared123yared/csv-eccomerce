import 'package:flutter/material.dart';

class ProductCategory extends StatefulWidget {
  final String title;
  ProductCategory({required this.title});
  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  Color _color = Color(0xFF015777).withOpacity(0.05);
  Color _fontColor = Colors.black.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    // this._color = Theme.of(context).primaryColor.withOpacity(0.07);
    return GestureDetector(
        onTap: () {
          setState(() {
            this._color = Theme.of(context).primaryColor;
            this._fontColor = Colors.white;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  color: this._color, borderRadius: BorderRadius.circular(15)),
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.035,
              child: Center(
                child: Text(
                  widget.title,
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: this._fontColor),
                ),
              )),
        ));
  }
}
