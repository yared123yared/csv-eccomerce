import 'dart:convert';

import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/clients/Common/pill_text.dart';
import 'package:app/Widget/clients/client_profile/basic_info.dart';
import 'package:app/Widget/clients/client_profile/menu.dart';
import 'package:app/Widget/clients/client_profile/orders_table.dart';
import 'package:app/Widget/clients/client_profile/table_header.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'drawer.dart';

class ClientProfileCopy extends StatefulWidget {
  // final LoggedUserInfo user;

  // const ClientProfile({
  //   required this.user,
  // });
  ClientProfileCopy();
  static const routeName = 'client_profile';

  @override
  _ClientProfileCopyState createState() => _ClientProfileCopyState();
}

class _ClientProfileCopyState extends State<ClientProfileCopy> {
  Future<LoggedUserInfo> getProfileInfo() async {
    UserPreferences userPreferences = new UserPreferences();
    LoggedUserInfo? info = await userPreferences.getUserInformation();
    LoggedUserInfo hinfo = info as LoggedUserInfo;
    print(jsonEncode(hinfo).toString());
    return hinfo;
  }

  String name = '';
  String email = '';
  String phone = '';
  String credit = "0";
  String? photopath = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: FutureBuilder<LoggedUserInfo>(
            future: getProfileInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<LoggedUserInfo> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(
                    'Error Occured while Fetching client profile',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if (snapshot.data != null) {
                if (snapshot.data!.user != null) {
                  if (snapshot.data!.user!.firstName != null) {
                    name = snapshot.data!.user!.firstName!;
                  }
                  if (snapshot.data!.user!.lastName != null) {
                    name += " " + snapshot.data!.user!.lastName!;
                  }
                  if (snapshot.data!.user!.email != null) {
                    email = snapshot.data!.user!.email!;
                  }
                  if (snapshot.data!.user!.phone != null) {
                    phone = snapshot.data!.user!.phone!;
                  }
                  if (snapshot.data!.user!.credit != null) {
                    credit = snapshot.data!.user!.credit!;
                  }
                  if (snapshot.data!.user!.photo != null) {
                    if (snapshot.data!.user!.photo!.filePath != null) {
                      photopath = snapshot.data!.user!.photo!.filePath!;
                    }
                  }
                }
              }
              print("-------name");
              print(name);

              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  ClientBasicProfile(
                    client: ClientProfileData(
                      name: name,
                      credit: credit,
                      level: 'Premiem',
                      email: email,
                      phone: phone,
                      photoPath: photopath,
                    ),
                  ),
                  MenuItem(
                    title: 'Order',
                    childrens: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TableHeader(start: 1, end: 5, total: 5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Orderstable(
                          orders: [],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MenuItem(
                    title: 'Document',
                    childrens: [],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MenuItem(
                    title: 'Shipping Addresses',
                    childrens: [],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MenuItem(
                    title: 'Billing Addresses',
                    childrens: [],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
