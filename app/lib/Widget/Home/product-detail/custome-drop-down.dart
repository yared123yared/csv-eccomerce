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
      print("Initially the dropdown attributes is null");
      dropdownValue = size[0];
      // selectedAttributesObject.add(dropdownValue!);
      int counter = 0;
      for (int i = 0; i < product.selectedAttributes!.length; i++) {
        if (product.selectedAttributes![i].name!.contains("Size")) {
          print("Size attribute already selected.");

          // product.selectedAttributes!
          //     .remove(product.selectedAttributes![i]);
          product.selectedAttributes![i] = dropdownValue!;
          counter += 1;
        }
      }
      if (counter == 0) {
        print("First selection of the attribute");
        product.selectedAttributes!.add(dropdownValue!);
      } else {
        print("Updating the attribute");
      }
      // product.selectedAttributes!.add(dropdownValue!);
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
          int counter = 0;
          // product.selectedAttributes!=[];
          for (int i = 0; i < product.selectedAttributes!.length; i++) {
            if (product.selectedAttributes![i].name!.contains("Size")) {
              print("Size attribute already selected.");

              // product.selectedAttributes!
              //     .remove(product.selectedAttributes![i]);
              product.selectedAttributes![i] = dropdownValue!;
              counter += 1;
            }
          }
          if (counter == 0) {
            print("First selection of the attribute");
            product.selectedAttributes!.add(dropdownValue!);
          } else {
            print("Updating the attribute");
          }

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
