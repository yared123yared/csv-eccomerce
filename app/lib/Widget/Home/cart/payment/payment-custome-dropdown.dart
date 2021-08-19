import 'package:flutter/material.dart';

class CustomeDropDownButton extends StatefulWidget {
  final List<DropdownMenuItem<int>> dropDownItems;
  CustomeDropDownButton({required this.dropDownItems});

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<CustomeDropDownButton> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 6,
        // left: 12,
      ),
      child: Material(
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
              items: widget.dropDownItems,
              onChanged: (int? value) {
                setState(() {
                  _value = value!;
                });
              },
              hint: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  "Select item",
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ),
    );
  }
}
