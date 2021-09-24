import 'package:app/models/product/attributes.dart';
import 'package:flutter/material.dart';

class ColorContainer extends StatefulWidget {
  final Attributes color;
  final Attributes selectedColor;
  final Function onPressed;

  // final bool selected;
  ColorContainer(
      {required this.color,
      required this.selectedColor,
      required this.onPressed});
  @override
  _ColorContainerState createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    print("Color option selected: ${widget.color.pivot!.value}");
    // final isSelected = false;
    return InkWell(
        onTap: () {
          print("tapped this color ${widget.color.toString()}");
          widget.onPressed(widget.color, null);
        },
        child: widget.selectedColor.pivot!.id != widget.color.pivot!.id
            ? Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color:
                          Color(int.parse("0xFF${widget.color.pivot!.value!}")),
                      shape: BoxShape.circle),
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Colors.grey[600]!,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ))
            : Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.done,
                      color:
                          Color(int.parse("0xFF${widget.color.pivot!.value!}")),
                      size: 20),
                )));
  }
}
