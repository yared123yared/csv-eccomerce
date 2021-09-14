import 'package:app/models/client.dart';
import 'package:app/screens/invoices_screen.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Client client;
  AddButton({required this.client});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          // width: MediaQuery.of(context).size.width * 0.08,
          // height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
                              color: Colors.green[400],

              borderRadius: BorderRadius.circular(5)),
          child: Container(
            padding: EdgeInsets.all(2),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InvoicesScreen(
                      client: this.client,
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
