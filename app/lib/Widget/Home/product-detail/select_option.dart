import 'package:app/Widget/Home/category/custome_category.dart';
import 'package:flutter/material.dart';

import 'product_custome_selection.dart';

class SelectOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            ProductCustomeSelection(
              backgroundColor: Theme.of(context).accentColor,
              fontColor: Colors.black,
              onPressed: () {},
              text: 'Description',
            ),
            ProductCustomeSelection(
              backgroundColor: Theme.of(context).primaryColor,
              fontColor: Colors.white,
              onPressed: () {},
              text: 'Product Details',
            ),
          ],
        ),
      ),
    );
  }
}
