import 'dart:convert';
import 'package:app/Widget/clients/client_profile/basic_info.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/navigation/profile_data.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  String creditLimitStartDate = '';
  String creditLimitEndDate = '';
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
                  if (snapshot.data!.user!.creditLimitEndDate != null) {
                    creditLimitEndDate =
                        snapshot.data!.user!.creditLimitEndDate!;
                  }
                  if (snapshot.data!.user!.creditLimitStartDate != null) {
                    creditLimitStartDate =
                        snapshot.data!.user!.creditLimitStartDate!;
                  }
                }
              }
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
                      creditLimitEndDate: creditLimitEndDate,
                      creditLimitStartDate: creditLimitStartDate,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
