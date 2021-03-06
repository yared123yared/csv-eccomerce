import 'package:app/Blocs/dashBoard/recentOrder/bloc/recent_order_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCDashBoard extends StatefulWidget {
  @override
  State<SearchCDashBoard> createState() => _SearchCDashBoardState();
}

class _SearchCDashBoardState extends State<SearchCDashBoard> {
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
                BlocProvider.of<RecentOrderBloc>(context)
                    .add(SearchRecentOrderEvent(value));
              },
              decoration: InputDecoration(
                hintText: cubit.tSearchbyName(),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    BlocProvider.of<RecentOrderBloc>(context)
                        .add(FeatchRecentOrderEvent());
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
