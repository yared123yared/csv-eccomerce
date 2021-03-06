import 'dart:convert';

import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/Widget/clients/clients_list/deleteButton.dart';
import 'package:app/Widget/clients/clients_list/edit_button.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/client.dart';
import 'package:app/models/route_args.dart';
import 'package:app/screens/client_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Common/client_data_row.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final VoidCallback deleteClient;
  final Function editClient;
  ClientCard({
    required this.client,
    required this.deleteClient,
    required this.editClient,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
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
              ClientDataRow(
                property: cubit.tNAME(),
                value: "${client.firstName} ${client.lastName}",
              ),
              ClientDataRow(
                  property: 'Mobile',
                  value: this.client.mobile == null ? "" : this.client.mobile!),
              ClientDataRow(
                  property: cubit.tQUANTITY(),
                  value: this.client.orders == null
                      ? "0"
                      : this.client.orders!.length.toString()),
              ClientDataRow(
                  property: cubit.tSTATUS(),
                  value: this.client.status == null
                      ? "INACTIVE"
                      : this.client.status == 1
                          ? "ACTIVE"
                          : "INACTIVE"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EditButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(
                        ClientEditScreen.routeName,
                        arguments: ClientEditArgs(
                          client: this.client,
                          from: "clients",
                        ),
                      )
                          .then((value) {
                        SyncDataToServerEvent syncClientEvent =
                            SyncDataToServerEvent();
                        BlocProvider.of<ClientsBloc>(context)
                            .add(syncClientEvent);
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DeleteButton(
                    onPressed: () {
                      delete(context);
                    },
                  ),
                ],
              )
            ],
          ),
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
