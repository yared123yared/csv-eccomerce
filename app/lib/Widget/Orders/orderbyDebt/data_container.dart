import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_cubit.dart';
import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_state.dart';
import 'package:app/Widget/Orders/allOrders/print_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainerOrderByDebt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderByDebtCubit, OrderByDebtState>(
      builder: (context, index) {
        final cubit = OrderByDebtCubit.get(context);
        final cubitData = cubit.orderByDebtModel.data;
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
                      dateApi:
                          "${cubit.orderByDebtModel.data![index].createdAt}",
                    ),
                    buildrowData(
                      text: 'ORDER',
                      dateApi:
                          "${cubit.orderByDebtModel.data![index].orderNumber}",
                    ),
                    buildrowData(
                      text: 'CLIENT ',
                      dateApi:
                          "${cubitData![index].client!.firstName} ${cubitData[index].client!.lastName}",
                    ),
                    buildrowData(
                      text: 'TOTAL',
                      dateApi: '${cubit.orderByDebtModel.data![index].total}',
                    ),
                    buildrowData(
                      text: 'DEBT',
                      dateApi:
                          '${cubit.orderByDebtModel.data![index].amountRemaining}',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xff48c2d5),
                            foregroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                PrintButton(
                                  index: index,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.pink,
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
          itemCount: cubit.orderByDebtModel.data!.length,
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
              height: 20,
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
            height: 20,
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
