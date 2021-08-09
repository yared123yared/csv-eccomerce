import 'package:flutter/material.dart';

class Shipping extends StatelessWidget {
  final List<Widget> textInput;
  final Function onNextPressed;
  final Function onDefaultAddressPressed;
  final Function onBillingAddressPressed;
  final Function onAddNewPressed;
  final bool isDefault;
  final bool isBilling;
  Shipping({
    required this.textInput,
    required this.onNextPressed,
    required this.onDefaultAddressPressed,
    required this.onBillingAddressPressed,
    required this.onAddNewPressed,
    required this.isDefault,
    required this.isBilling,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...this.textInput.map(
              (e) => Column(
                children: [
                  e,
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Switch(
              value: this.isBilling,
              onChanged: (val) => this.onBillingAddressPressed(),
            ),
            Text(
              'Billing Address',
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Switch(
                  value: this.isDefault,
                  onChanged: (val) => this.onDefaultAddressPressed(),
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
              onTap: () => this.onAddNewPressed(),
              child: Text(
                'Add New',
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
