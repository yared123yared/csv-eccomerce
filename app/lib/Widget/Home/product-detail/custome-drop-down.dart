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
  Attributes? dropdownValue = null;
  // List<Attributes> selectedAttributesObject = [];

  @override
  Widget build(BuildContext context) {
    Data product = widget.product;
    List<Attributes?> size = [];

    for (int i = 0; i < product.attributes!.length; i++) {
      List<Attributes> attributes = product.attributes as List<Attributes>;
      if (attributes[i].name!.contains('Size')) {
        print("Size:  ${attributes[i].pivot!.value}");
        size.add(attributes[i]);
      }
    }

    if (dropdownValue == null) {
      dropdownValue = size[0];
      // selectedAttributesObject.add(dropdownValue!);
       product.selectedAttributes!.add(dropdownValue!.pivot!.id as int);
    }

    return DropdownButton<Attributes>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (Attributes? newValue) {
          print("Newly selected attributes: ${newValue!.pivot!.id}");
          setState(() {
            dropdownValue = newValue;
            // selectedAttributesObject = [];
          });
          // for (int i = 0; i < selectedAttributesObject.length; i++) {
          //   //
          //   if (selectedAttributesObject[i].id == newValue.id) {
          //     print("this attributes have already been selected");
          //     selectedAttributesObject.remove(selectedAttributesObject[i]);
          //     selectedAttributesObject.add(newValue);
          //   }
          // }
          // selectedAttributesObject.add(newValue);
          // for(int i=0;i< selectedAttributesObject.length;i++){
          //   //
          //   if()

          // }
          // for (int i = 0; i < selectedAttributesObject.length; i++) {
          //   if (product.selectedAttributes!
          //       .contains(selectedAttributesObject[i].pivot!.id)) {
          //     print("Attributes selected");
          //   } else {
          //     product.selectedAttributes!
          //         .add(selectedAttributesObject[i].pivot!.id as int);
          //   }
          // }
          product.selectedAttributes!.removeLast();
          product.selectedAttributes!.add(dropdownValue!.pivot!.id as int);

          // product.selectedAttributes!.add(newValue.pivot!.id as int);
          print("Attributes: ${product.selectedAttributes}");
        },
        // ignore: unnecessary_null_comparison
        items: size == null
            ? null
            : size.map<DropdownMenuItem<Attributes>>((Attributes? value) {
                return DropdownMenuItem<Attributes>(
                  value: value,
                  child: Text(value!.pivot!.value!),
                );
              }).toList());
  }
}
