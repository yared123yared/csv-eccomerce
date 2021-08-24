import 'package:app/Widget/Home/category/custome_category.dart';
import 'package:flutter/material.dart';

import 'product_custome_selection.dart';

class SelectOption extends StatelessWidget {
  final Function onPressed;
  final int state;
  SelectOption({required this.onPressed, required this.state});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            ProductCustomeSelection(
              backgroundColor: this.state == 0
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor,
              fontColor: this.state == 0 ? Colors.white : Colors.black,
              onPressed: () => this.onPressed(0),
              text: 'Description',
            ),
            ProductCustomeSelection(
              backgroundColor: this.state == 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor,
              fontColor: this.state == 1 ? Colors.white : Colors.black,
              onPressed: () => this.onPressed(1),
              text: 'Product Details',
            ),
          ],
        ),
      ),
    );
  }
}
