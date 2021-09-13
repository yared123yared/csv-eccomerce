import 'package:app/Widget/clients/Common/client_data_row.dart';
import 'package:app/Widget/clients/Common/pill_text.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:flutter/material.dart';

import 'change-client-button.dart';

class ClientProfile extends StatelessWidget {
  final ClientProfileData client;
  ClientProfile({required this.client});
  void editClient() {}

  @override
  Widget build(BuildContext context) {
    String image =
        'https://csv.jithvar.com/storage/${this.client.photoPath.toString()}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        alignment: Alignment.center,
        textDirection: TextDirection.rtl,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 300,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          this.client.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.ballot),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    ChangeClientButton(),
                    SizedBox(
                      height: 20.0,
                    ),
                    ClientDataRow(property: 'NAME', value: this.client.name),
                    ClientDataRow(
                        property: 'EMAIL', value: '${this.client.email}'),
                    ClientDataRow(
                        property: 'PHONE', value: '${this.client.phone}'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -40,
            child: CircleAvatar(
              radius: 40,
              child: Container(
                clipBehavior: Clip.hardEdge,
                child: Image.network(image),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
