import 'package:app/Widget/clients/Common/pill_text.dart';
import 'package:app/models/client.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:flutter/material.dart';

import '../Common/client_data_row.dart';

class AddressInfo extends StatelessWidget {
  final Addresses address;
  AddressInfo({required this.address});
  void editClient() {}
  String streetAddress = "";
  String zipCode = "";
  String locality = "";
  String city = "";
  String state = "";
  @override
  Widget build(BuildContext context) {
    if (address.streetAddress != null) {
      streetAddress = address.streetAddress!;
    }
    if (address.zipCode != null) {
      zipCode = address.zipCode!;
    }
    if (address.locality != null) {
      locality = address.locality!;
    }
    if (address.city != null) {
      city = address.city!;
    }
    if (address.state != null) {
      state = address.state!;
    }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        height: 250,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 10),
            AddressDataRow(
                property: 'STREET ADDRESS',
                value: streetAddress),
            AddressDataRow(property: 'ZIP CODE', value: zipCode),
            AddressDataRow(property: 'LOCALITY', value: locality),
            AddressDataRow(property: 'CITY', value: city),
            AddressDataRow(property: 'STATE', value: state),
            AddressDataRow(
                property: 'COUNTRY', value: '${this.address.country}'),
          ],
        ),
      ),
    );
  }
}
