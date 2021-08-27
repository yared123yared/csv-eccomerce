import 'package:app/Widget/clients/Common/pill_text.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:flutter/material.dart';

import '../Common/client_data_row.dart';

class ClientBasicProfile extends StatelessWidget {
  final ClientProfileData client;
  ClientBasicProfile({required this.client});
  void editClient() {}
  final String baseUrl = 'http://csv.jithvar.com/storage';

  @override
  Widget build(BuildContext context) {
    Widget photo;
    if (client.photoPath == null) {
      photo = CircleAvatar(
        radius: 40,
        child: Container(
          clipBehavior: Clip.hardEdge,
          child: Image.asset('assets/images/circular.png'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    } else {
      photo = CircleAvatar(
        radius: 40,
        child: Container(
          clipBehavior: Clip.hardEdge,
          child: Image.network('${baseUrl}/${client.photoPath}'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    }
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
              elevation: 5,
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
                    InkWell(
                      onTap: () {},
                      child: PillText(
                        text: 'Edit',
                        bgColor: Color(0xFFF2F6F9),
                        fgColor: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ClientDataRow(property: 'NAME', value: this.client.name),
                    ClientDataRow(
                        property: 'CREDIT', value: '${this.client.credit}'),
                    ClientDataRow(
                        property: 'LEVEL', value: '${this.client.level}'),
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
              child:photo,
            ),
          ),
        ],
      ),
    );
  }
}
