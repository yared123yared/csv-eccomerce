import 'package:flutter/material.dart';
// import '../Common/custom_textfield.dart';

class GeneralInformation extends StatelessWidget {
  final List<Widget> textInput;
  final GlobalKey<FormState> formKey;

  GeneralInformation({
    required this.textInput,
    required this.formKey,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...this.textInput.map(
                  (e) => Column(
                    children: [
                      e,
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
