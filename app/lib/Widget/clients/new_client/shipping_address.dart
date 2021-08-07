import 'package:flutter/material.dart';
import '../Common/custom_textfield.dart';

class Shipping extends StatelessWidget {
  final List<Widget> textInput;
  final Function onNextPressed;
  final Function onDefaultAddressPressed;
  final Function onAddNewPressed;

  Shipping({
    required this.textInput,
    required this.onNextPressed,
    required this.onDefaultAddressPressed,
    required this.onAddNewPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...this.textInput.map((e) => Column(
              children: [
                e,
                SizedBox(
                  height: 10,
                )
              ],
            )),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Switch(
                  value: false,
                  onChanged: this.onDefaultAddressPressed(),
                ),
                Text(
                  'Default Address',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: this.onAddNewPressed(),
              child: Text(
                ' Add New',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
