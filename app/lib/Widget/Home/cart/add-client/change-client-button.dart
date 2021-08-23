import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeClientButton extends StatelessWidget {
  late AddClientBloc addClientBloc;
  @override
  Widget build(BuildContext context) {
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text("Change Client",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          onTap: () {
            addClientBloc.add(ClientSearchEvent());
            // Navigator.pop(context);
            // Navigator.pushNamed(context, AddClient.routeName);
          }),
    );
  }
}
