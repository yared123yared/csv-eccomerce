import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_cubit.dart';
import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContainerColl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionReportCubit, CollectionReportState>(
        builder: (context, state) {
      final cubit = CollectionReportCubit.get(context);
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
                controller: cubit.searchController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (String value) {
                  // cubit.postSalesReport(
                  //   nameSearch: value,
                  //   dateFrom: "",
                  //   dataTo: "",
                  // );
                  // if (value == cubit.searchController.text) {}
                },
                onChanged: (String value) {},
                decoration: InputDecoration(
                  hintText: 'Search by Date,Name,Name order',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.searchController.clear();
                    },
                    icon: Icon(Icons.close),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),

              // child: TextField(
              //   controller: cubit.searchController,
              //   decoration: InputDecoration(
              //     prefixIcon: IconButton(
              //       onPressed: () {},
              //       icon: Icon(
              //         Icons.search,
              //         color: Colors.grey,
              //         size: 35,
              //       ),
              //     ),
              //     border: InputBorder.none,
              //     hintText: "Search by Date,Name,Name order",
              //     hintStyle: const TextStyle(
              //       fontSize: 16,
              //       color: Colors.black45,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(40),
              //       borderSide:
              //           const BorderSide(color: Color(0xffd2dfea), width: 1),
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      );
    });
  }
}
