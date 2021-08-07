import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final List<Widget> childrens;
  const MenuItem({
    required this.title,
    required this.childrens,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      margin: EdgeInsets.symmetric(horizontal: 16.0),

      child: Material(
        elevation: 5,
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        clipBehavior: Clip.hardEdge,
        child: ExpansionTile(
          backgroundColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black,

          title: Text(
            this.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: this.childrens,
        ),
      ),
    );
  }
}
