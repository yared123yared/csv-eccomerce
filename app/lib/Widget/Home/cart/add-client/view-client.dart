import 'package:app/models/navigation/profile_data.dart';

import 'package:flutter/material.dart';

import 'client-profile.dart';

class ViewCient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      ClientProfile(
        client: ClientProfileData(
          name: 'Folakam Olivier',
          credit: 0,
          level: 'Premiem',
          email: 'fokamolvier@gmail.com',
          phone: '237945521',
        ),
      ),
    ]);
  }
}
