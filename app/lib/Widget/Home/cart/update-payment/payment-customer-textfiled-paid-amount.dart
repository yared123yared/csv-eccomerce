import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePaymentCustomTextFieldPaidAmount extends StatelessWidget {
  final String? textFieldName;
  final TextEditingController? controller;
  final Function? validator;
  final bool? obsecureText;
  final bool? isRequired;
  final String? initialValue;
  final Function? onChanged;
  UpdatePaymentCustomTextFieldPaidAmount({
    this.textFieldName,
    this.controller,
    this.validator,
    this.obsecureText,
    this.isRequired,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return Container(
          width: loginSize.getTextFieldWidth,
          child: TextFormField(
            controller: this.controller,
            // obscureText: this.obsecureText,
            initialValue: this.initialValue,
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'This field is required';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: (value) => this.onChanged!(value.toString()),
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            decoration: new InputDecoration(
              labelText: this.textFieldName,
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              print("State of the credit: ${state.credit}");
              if (val!.length == 0) {
                return "This field is required";
              } else if (state.credit! < double.parse(val)) {
                print("Entered to the validator");
                return "Credit Limit Exceed";
              } else if(state.request.total!<double.parse(val)){
                return "Value greater than the total value";
              }
              else {
                return null;
              }
            },
            // keyboardType: TextInputType.emailAddress,
          ),
        );
      },
    );
  }

  // bool validatAmount(String value) async {
  //   print("Value Added: ${value}");
  //   UserPreferences userPreference = new UserPreferences();
  //   LoggedUserInfo loggedUserInfo =
  //       await userPreference.getUserInformation() as LoggedUserInfo;
  //   User user = loggedUserInfo.user as User;
  //   int credit = int.parse(user.credit as String);
  //   if (int.parse(value) > credit) {
  //     return false;
  //   }
  //   return false;
  // }
}
