import 'package:app/Widget/clients/clients_list/deleteButton.dart';
import 'package:app/Widget/clients/clients_list/edit_button.dart';
import 'package:flutter/material.dart';

import '../Common/client_data_row.dart';

class Client extends StatelessWidget {
  String name;
  String mobile;
  String email;
  String status;
  Client({
    required this.email,
    required this.mobile,
    required this.name,
    required this.status,
  });
  void deletClient() {}
  void editClient() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 200,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              ClientDataRow(property: 'NAME', value: this.name),
              ClientDataRow(property: 'Mobile', value: this.mobile),
              ClientDataRow(property: 'QUANTITY', value: '${this.email}'),
              ClientDataRow(property: 'STATUS', value: '${this.status}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EditButton(
                    onPressed: () => editClient(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DeleteButton(
                    onPressed: () => deletClient(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
