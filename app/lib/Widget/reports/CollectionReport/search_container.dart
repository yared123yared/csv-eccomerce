import 'package:app/Blocs/reports/CollectionReport_cubit/bloc/collection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContainerColl extends StatefulWidget {
  @override
  _SearchContainerCollState createState() => _SearchContainerCollState();
}

class _SearchContainerCollState extends State<SearchContainerColl> {
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
                BlocProvider.of<CollectionBloc>(context)
                    .add(SearchCollectionEvent(value));
              },
              decoration: InputDecoration(
                hintText: 'Search by Name',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    BlocProvider.of<CollectionBloc>(context)
                        .add(FeatchCollectionEvent());
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
