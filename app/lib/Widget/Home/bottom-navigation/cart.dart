import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  final int value;
  final int check;
  Cart({required this.value, required this.check});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      textDirection: TextDirection.rtl,
      fit: StackFit.loose,
      overflow: Overflow.visible,
      clipBehavior: Clip.hardEdge,
      children: [
        Image.asset(
          'assets/icons/cart2.png',
          color: check == 2 ? Theme.of(context).primaryColor : Colors.grey,
        ),
        Positioned(
            left: 20,
            bottom: 15,
            child: Container(
              // width: 30,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  "$value",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}
