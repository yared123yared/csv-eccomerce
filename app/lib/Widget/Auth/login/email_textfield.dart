// import 'package:flutter/material.dart';

<<<<<<< HEAD:app/lib/Widget/login/email_textfield.dart
// import 'custom_textfield.dart';
=======
import '../Common/custom_textfield.dart';
>>>>>>> 64d86357796780782e031da3ea8f1b019771ae81:app/lib/Widget/Auth/login/email_textfield.dart

// class EmailTextField extends StatelessWidget {
//   late final EmailEditingController;

//   EmailTextField({required this.EmailEditingController});

<<<<<<< HEAD:app/lib/Widget/login/email_textfield.dart
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextField(

//       textFieldName: "Enter Email",
//       controller: this.EmailEditingController,
//     );
//   }
// }
=======
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        textFieldName: "Enter Email",
        controller: this.EmailEditingController,
        icon: Icon(
          Icons.email,
          color: Colors.black,
        ));
  }
}
>>>>>>> 64d86357796780782e031da3ea8f1b019771ae81:app/lib/Widget/Auth/login/email_textfield.dart
