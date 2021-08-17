import 'dart:convert';

import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/clients_list/deleteButton.dart';
import 'package:app/Widget/clients/clients_list/edit_button.dart';
import 'package:app/models/client.dart';
import 'package:app/screens/client_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add-button.dart';

class ClientItem extends StatelessWidget {
  final Client client;

  ClientItem({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.035,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.client.firstName == null ? "" : this.client.firstName!),
            Text(this.client.mobile == null ? "" : this.client.mobile!),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AddButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void delete(BuildContext context) {
    print('delete executing');
    DeleteClientEvent deleteEvent =
        new DeleteClientEvent(id: this.client.id.toString());
    BlocProvider.of<ClientsBloc>(context, listen: false).add(deleteEvent);
  }
}
