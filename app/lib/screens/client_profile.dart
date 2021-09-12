import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/clients/Common/pill_text.dart';
import 'package:app/Widget/clients/client_profile/basic_info.dart';
import 'package:app/Widget/clients/client_profile/menu.dart';
import 'package:app/Widget/clients/client_profile/orders_table.dart';
import 'package:app/Widget/clients/client_profile/table_header.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class ClientProfile extends StatefulWidget {
  // final LoggedUserInfo user;

  // const ClientProfile({
  //   required this.user,
  // });
  ClientProfile();
  static const routeName = 'client_profile';

  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clients Profile',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ClientBasicProfile(
              client: ClientProfileData(
                name: 'Folakam Olivier',
                credit: "0",
                level: 'Premiem',
                email: 'fokamolvier@gmail.com',
                phone: '237945521',
                creditLimitEndDate: "",
                creditLimitStartDate: "",
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
        ),
      ),
    );
  }
}
