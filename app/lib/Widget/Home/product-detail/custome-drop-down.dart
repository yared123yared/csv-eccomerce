import 'package:app/models/product/attributes.dart';
import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';

class CustomeDropDown extends StatefulWidget {
  final Data product;
  CustomeDropDown({required this.product});
  @override
  _CustomeDropDownState createState() => _CustomeDropDownState();
}

class _CustomeDropDownState extends State<CustomeDropDown> {
  late String? dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    Data product = widget.product;
    List<String?> size = [];

    for (int i = 0; i < product.attributes!.length; i++) {
      List<Attributes> attributes = product.attributes as List<Attributes>;
      if (attributes[i].name!.contains('Size')) {
        print("Size:  ${attributes[i].pivot!.value}");
        size.add(attributes[i].pivot!.value);
      }
    }
    if (dropdownValue == '') {
      dropdownValue = size[0];
    }

    return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: size == null
            ? null
            : size.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value!),
                );
              }).toList());
  }
}
