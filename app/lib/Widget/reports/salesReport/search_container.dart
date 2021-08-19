import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_cubit.dart';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_state.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReportCubit, SalesReportState>(
      builder: (context, state) {
        final cubit = SalesReportCubit.get(context);
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
                    cubit.postSalesReport(
                      nameSearch: value,
                      dateFrom: "",
                      dataTo: "",
                    );
                    // if (value == cubit.searchController.text) {}
                  },
                  onChanged: (String value) {},
                  decoration: InputDecoration(
                    hintText: 'Search by Date,Name,Name order',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.searchController.clear();
                        cubit.postSalesReport(
                            nameSearch: "", dateFrom: "", dataTo: "");
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
      },
    );
  }
}
