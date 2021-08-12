  import 'package:flutter/material.dart';

DropdownMenuItem<String> buildMenuItems(String item) {
    return DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          Text(
            item,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff414e79),
            ),
          ),
        ],
      ),
    );
  }

  Widget salesReportButton({
    required String text,
    required Function onpressed,
  }) =>
      ElevatedButton(
        onPressed: () => onpressed(),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xff2c9eee),
        ),
        child: Text(text),
      );

  Widget containerBorder({
    required double height,
    required double width,
    required Widget child,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffd2dfea),
          ),
        ),
        child: child,
      );