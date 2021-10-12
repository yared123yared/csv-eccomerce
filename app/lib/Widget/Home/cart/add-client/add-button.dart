import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/client_address/address/bloc/address_id_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddButton extends StatefulWidget {
  final Client client;
  AddButton({required this.client});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  late AddClientBloc addClientBloc;

  late OrdersBloc ordersBloc;

  @override
  Widget build(BuildContext context) {
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AddressIdBloc>(context)
            .add(FeatchAddressIdEvent(widget.client.id!));
        // print("walid mahmoud rageb ");
        // print(widget.client.id!);
        // print("walid mahmoud rageb ");
        cubit.addersIdy = widget.client.id!;
        addClientBloc.add(ClientDisplayEvent(client: this.widget.client));
        ordersBloc.add(ClientAddEvent(client: this.widget.client));
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
