import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Widget/Home/cart/add-client/client-title.dart';
import 'package:app/Widget/Home/cart/add-client/search-bar.dart';
import 'package:app/Widget/Home/cart/add-client/view-client.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'client-display.dart';
import 'search-client.dart';

class UpperContainer extends StatefulWidget {
  @override
  _UpperContainerState createState() => _UpperContainerState();
}

class _UpperContainerState extends State<UpperContainer> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClientBloc, AddClientState>(
      builder: (context, state) {
        if (state.display_state == true) {
          return ViewCient();
        } else {
          return SearchClient();
        }
      },
    );
  }

  void changeState() {
    setState(() {
      this.isChecked = !this.isChecked;
    });
  }
}
