import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/constants/login/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginSize loginSize = new LoginSize();
    loginSize.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40)),
          width: loginSize.getTextFieldWidth,
          child: TextField(
            controller: null,
            // obscureText: !ispassshow,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onChanged: (val) {
              print("---value--${val}");
              if (val != null || val != '') {
                SearchClientsEvent searchClientEvent =
                    new SearchClientsEvent(key: val);
                BlocProvider.of<ClientsBloc>(context, listen: false)
                    .add(searchClientEvent);
              }else{
                FetchClientsEvent fetchClientEvent =
                    new FetchClientsEvent(page: 0);
                BlocProvider.of<ClientsBloc>(context, listen: false)
                    .add(fetchClientEvent);
              }
            },
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              // suffixIcon: IconButton(
              //   icon: Icon(ispassshow
              //       ? Icons.visibility
              //       : Icons.visibility_off),
              //   onPressed: () {
              //     setState(() {
              //       ispassshow = !ispassshow;
              //     });
              //   },
              // ),
              hintText: "Search By Name Mobile , Email",
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
            ),
          ),
        ),
      ),
    );
  }
}
