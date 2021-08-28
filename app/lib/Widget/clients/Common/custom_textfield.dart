import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldName;
  final TextEditingController controller;
  final Function validator;
  final bool obsecureText;
  final bool isRequired;
  final String initialValue;
  CustomTextField({
    required this.textFieldName,
    required this.controller,
    required this.validator,
    required this.obsecureText,
    required this.isRequired,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return
        // Material(
        //   color: Colors.white,
        //   elevation: 1.0,
        //   clipBehavior: Clip.hardEdge,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(40),
        //   ),
        //   textStyle: TextStyle(color: Colors.black),
        //   child:
        Container(
      width: loginSize.getTextFieldWidth,
      child: TextFormField(
        controller: this.controller,
        obscureText: this.obsecureText,
        // initialValue: this.initialValue,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        style: TextStyle(fontSize: 18, color: Colors.grey),
        decoration: InputDecoration(
          labelText: this.textFieldName,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green

          contentPadding: EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: 12,
          ),
          // border: InputBorder.none,
          // prefixText: '${this.textFieldName}',
          suffixIcon: Container(
            width: 2,
            child: Center(
              child: this.isRequired
                  ? Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : Text(''),
            ),
          ),

          // hintText: '${this.textFieldName}',
          errorStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic,
          ),
          // errorMaxLines: 1,
          // hintText: "${this.textFieldName}",
        ),
        validator: (value) {
          String? xx = this.validator(value);
          print("----");
          if(xx!=null)
          print(xx);
        },
      ),
      // )
    );
  }
}
