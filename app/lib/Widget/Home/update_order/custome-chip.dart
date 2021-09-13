import 'package:flutter/material.dart';

class CustomeChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
          radius: 10,
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.add,
            size: 16,
          )),
    );
  }
}
