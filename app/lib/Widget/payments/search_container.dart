import 'package:app/Blocs/Payments/bloc/bankslip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPaymentScreen extends StatefulWidget {
  @override
  _SearchPaymentScreenState createState() => _SearchPaymentScreenState();
}

class _SearchPaymentScreenState extends State<SearchPaymentScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          height: 40,
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (String value) {
              BlocProvider.of<BankslipBloc>(context)
                  .add(SearchBankslipEvent(value));
            },
            decoration: InputDecoration(
              hintText: 'Search by Amount',
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  BlocProvider.of<BankslipBloc>(context)
                      .add(FeatchBankslipEvent());
                },
                icon: Icon(Icons.close),
              ),
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
