import 'package:flutter/material.dart';

class ClientListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.035,
          color: Theme.of(context).primaryColor.withOpacity(0.075),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Name"),
              ),
              Text("Mobile"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.12,
              )
            ],
          )),
    );
  }
}
