import 'package:flutter/material.dart';

class SearchCDashBoard extends StatefulWidget {
  @override
  State<SearchCDashBoard> createState() => _SearchCDashBoardState();
}

class _SearchCDashBoardState extends State<SearchCDashBoard> {
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
              onFieldSubmitted: (String value) {},
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
