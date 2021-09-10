import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/models/navigation/profile_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'client-profile.dart';

class ViewCient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      BlocBuilder<AddClientBloc, AddClientState>(
        builder: (context, state) {
          if (state is StateChanged) {
            return ClientProfile(
              client: ClientProfileData(
                name:
                    "${state.client!.firstName.toString()}  ${state.client!.lastName.toString()}",
                credit: "0",
                level: 'Premiem',
                email: state.client!.email.toString(),
                phone: state.client!.mobile.toString(),
                creditLimitEndDate: "",
                creditLimitStartDate: ""
              ),
            );
          }
          return Container();
        },
      )
    ]);
  }
}
