import 'package:flutter/material.dart';
// import '../Common/custom_textfield.dart';

class GeneralInformation extends StatelessWidget {
  final List<Widget> textInput;
  GeneralInformation({
    required this.textInput,
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
      ],
    );
  }
}
