import 'package:flutter/material.dart';

class CustomeDropDownButton extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<CustomeDropDownButton> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    // List<DropdownMenuItem<int>> dropDownItems = [];
    return Material(
      color: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      textStyle: TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.9,
        child: DropdownButton(

            // focusColor: Theme.of(context).primaryColor,
            dropdownColor: Colors.white,
            // icon: Icon(Icons.category_outlined),
            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Business Broker"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Commodity Broker"),
                value: 2,
              ),
              DropdownMenuItem(
                child: Text("Customer Broker"),
                value: 3,
              ),
              DropdownMenuItem(
                child: Text("Information Broker"),
                value: 4,
              ),
              DropdownMenuItem(
                child: Text("Intelectual Broker"),
                value: 5,
              ),
              DropdownMenuItem(
                child: Text("Real estate Broker"),
                value: 6,
              ),
              DropdownMenuItem(
                child: Text("Sponsorship Broker"),
                value: 7,
              ),
              DropdownMenuItem(
                child: Text("Stock Broker"),
                value: 8,
              ),
              DropdownMenuItem(
                child: Text("Office Broker"),
                value: 11,
              ),
              DropdownMenuItem(
                child: Text("Service Broker"),
                value: 12,
              ),
              DropdownMenuItem(
                child: Text("Insurance Broker"),
                value: 13,
              ),
              DropdownMenuItem(
                child: Text("Discount Broker"),
                value: 14,
              ),
              DropdownMenuItem(
                child: Text("Credit Broker"),
                value: 15,
              ),
              DropdownMenuItem(
                child: Text("Leasing Broker"),
                value: 16,
              ),
            ],
            onChanged: (int? value) {
              setState(() {
                _value = value!;
              });
            },
            hint: Text(
              "Select item",
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
