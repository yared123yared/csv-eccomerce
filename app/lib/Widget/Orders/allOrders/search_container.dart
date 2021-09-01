import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContinerAllOrder extends StatefulWidget {
  @override
  _SearchContinerAllOrderState createState() => _SearchContinerAllOrderState();
}

class _SearchContinerAllOrderState extends State<SearchContinerAllOrder> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            height: 40,
            child: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (String value) {
                BlocProvider.of<AllorderrBloc>(context)
                    .add(SearchGetAllorderrEvent(value));
              },
              onChanged: (String value) {},
              decoration: InputDecoration(
                hintText: 'Search by Name',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: Icon(Icons.close),
                ),
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
