import 'package:app/Blocs/orderDrawer/OrderByDebt/bloc/orderbydebt_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchOrderBtDebt extends StatefulWidget {
  @override
  _SearchOrderBtDebtState createState() => _SearchOrderBtDebtState();
}

class _SearchOrderBtDebtState extends State<SearchOrderBtDebt> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
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
                BlocProvider.of<OrderbydebtBloc>(context)
                    .add(SearchOrderBydebtEvent(value));
              },
              onChanged: (String value) {},
              decoration: InputDecoration(
                hintText: cubit.tSearchbyName(),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    BlocProvider.of<OrderbydebtBloc>(context)
                        .add(FeatchOrderbydebtEvent());
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
