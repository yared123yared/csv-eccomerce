import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        // vertical: 4.0,
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 150,
          height: 40,
          child: TextField(
            controller: null,
            // obscureText: !ispassshow,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            style: TextStyle(fontSize: 16, color: Colors.grey),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              // suffixIcon: IconButton(
              //   icon: Icon(ispassshow
              //       ? Icons.visibility
              //       : Icons.visibility_off),
              //   onPressed: () {
              //     setState(() {
              //       ispassshow = !ispassshow;
              //     });
              //   },
              // ),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
            ),
          ),
        ),
      ),
    );
  }
}
