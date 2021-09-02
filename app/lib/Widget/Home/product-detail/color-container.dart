import 'package:flutter/material.dart';

class ColorContainer extends StatefulWidget {
  final Color color;
  final bool selected;
  ColorContainer({required this.color, required this.selected});
  @override
  _ColorContainerState createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    print("Color option selected: ${widget.color}");
    final isSelected = false;
    return InkWell(
        onTap: () {
          print("tapped this color ${widget.color.toString()}");
        },
        child:widget.selected==false?

            Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration:
                      BoxDecoration(color: widget.color, shape: BoxShape.circle),
                  child: Text(
                    '',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600]!,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )

                ):
            Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.done, color: widget.color, size: 20),
                ))
                
                );
  }
}
