import 'package:app/Blocs/reports/CustomerDebt/bloc/custom_debt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCustomerDebt extends StatefulWidget {
  @override
  _SearchCustomerDebtState createState() => _SearchCustomerDebtState();
}

class _SearchCustomerDebtState extends State<SearchCustomerDebt> {
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
                BlocProvider.of<CustomDebtBloc>(context)
                    .add(SearchCustomDebtEvent(value));
              },
              decoration: InputDecoration(
                hintText: 'Search by Name',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    BlocProvider.of<CustomDebtBloc>(context)
                        .add(FeatchCustomDebtEvent());
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
