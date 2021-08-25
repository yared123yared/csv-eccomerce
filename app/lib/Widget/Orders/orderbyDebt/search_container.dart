import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_cubit.dart';
import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchOrderBtDebt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderByDebtCubit, OrderByDebtState>(
      builder: (context, state) {
        final cubit = OrderByDebtCubit.get(context);
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
                    cubit.postOrdersByDebtSearch(
                      searchName: value,
                    );
                  },
                  onChanged: (String value) {},
                  decoration: InputDecoration(
                    hintText: 'Search by Name',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.searchController.clear();

                        cubit.postOrdersByDebt();
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