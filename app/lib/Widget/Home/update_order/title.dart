import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final String? name;
  ProductTitle({required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.03,
      child: AutoSizeText(
        "${name}",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }
}
