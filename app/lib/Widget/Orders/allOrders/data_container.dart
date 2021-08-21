import 'package:app/Blocs/orderDrawer/AllOrder/allorders_cubit.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/allorders_state.dart';
import 'package:app/Widget/Orders/allOrders/print_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainerAllOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllOrdersCubit, AllOredersState>(
      builder: (context, index) {
        final cubit = AllOrdersCubit.get(context);
        final cubitData = cubit.allOrdersModel.data;
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: 400,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildrowData(
                      text: 'DATE',
                      dateApi: "${cubit.allOrdersModel.data![index].createdAt}",
                    ),
                    buildrowData(
                      text: 'ORDER',
                      dateApi:
                          "${cubit.allOrdersModel.data![index].orderNumber}",
                    ),
                    buildrowData(
                      text: 'CLIENT ',
                      dateApi:
                          "${cubitData![index].client!.firstName} ${cubitData[index].client!.lastName}",
                    ),
                    buildrowData(
                      text: 'TOTAL',
                      dateApi: '${cubit.allOrdersModel.data![index].total}',
                    ),
                    buildrowData(
                      text: 'PAID AMOUNT',
                      dateApi:
                          '${cubit.allOrdersModel.data![index].amountPaid}',
                    ),
                    buildrowData(
                      text: 'DEBT',
                      dateApi: '${cubitData[index].client!.debts}',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PrintButton(
                            index: index,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20,
            );
          },
          itemCount: cubit.allOrdersModel.data!.length,
        );
      },
    );
  }

  Widget buildrowData({
    required String text,
    required String dateApi,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: 10,
            ),
            child: Container(
              height: 17,
              width: 150,
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 15,
            width: 150,
            child: Text(
              dateApi,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
}
