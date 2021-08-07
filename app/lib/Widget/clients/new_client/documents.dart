import 'package:app/Widget/clients/Common/custom_file_input.dart';
import 'package:app/Widget/clients/Common/file_pick_button.dart';
import 'package:app/Widget/clients/Common/step_button.dart';
import 'package:flutter/material.dart';
import '../Common/custom_textfield.dart';

class Documents extends StatelessWidget {
  final CustomTextField documentNameField;
  final CustomFileInput documentPicker;
  // final CustomFileButton fileInput;
  final Function onAddNewPressed;
  Documents({
    required this.documentNameField,
    required this.onAddNewPressed,
    required this.documentPicker,
    // required this.fileInput,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        documentNameField,
        SizedBox(
          height: 20.0,
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
        ),
        SizedBox(
          height: 15.0,
        ),
        this.documentPicker,
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
