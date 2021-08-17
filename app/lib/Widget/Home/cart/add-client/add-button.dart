import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddButton extends StatelessWidget {
  late AddClientBloc addClientBloc;
  @override
  Widget build(BuildContext context) {
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    return GestureDetector(
      onTap: () {
        addClientBloc.add(ClientDisplayEvent());
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.16,
          height: MediaQuery.of(context).size.height * 0.02,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
