import 'dart:convert';

import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/Widget/Orders/allOrders/Pdf/pdf_screen.dart';
import 'package:app/Widget/Orders/allOrders/search_container.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/request/request.dart';
import 'package:app/screens/cart_screens/update_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataContainerAllOrders extends StatefulWidget {
  @override
  _DataContainerAllOrdersState createState() => _DataContainerAllOrdersState();
}

class _DataContainerAllOrdersState extends State<DataContainerAllOrders> {
  late AllorderrBloc bloc;
  late AddClientBloc addClientBloc;
  late OrdersBloc ordersBloc;
  ScrollController _scrollController = ScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  List<DataAllOrders> dataAllOrder = [];
  List<DataAllOrders> searchdataAllOrder = [];
  int start = 0;
  int end = 0;
  int total = 0;

  @override
  void initState() {
    addClientBloc = BlocProvider.of<AddClientBloc>(context);
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    bloc = BlocProvider.of<AllorderrBloc>(context);
    bloc.add(FeatcAllorderrEvent());

    super.initState();
    print("initialize");

    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (dataAllOrder.isNotEmpty) {
              if (dataAllOrder.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );

    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value
          .map((item) => item.index)
          .toList();
      if (indices.length > 0) {
        setState(() {
          if (searchdataAllOrder.isNotEmpty) {
            if (searchdataAllOrder.length > 0) {
              start = indices[0] + 1;
              end = indices.length;
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // bloc.close();
    // ordersBloc.close();
    // addClientBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // addClientBloc = BlocProvider.of<AddClientBloc>(context);
    // ordersBloc = BlocProvider.of<OrdersBloc>(context);
    // print("data---container---1");
    // print(ordersBloc);
    // print(addClientBloc);
    // print(bloc);
    // print("------");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
          child: SearchContinerAllOrder(),
        ),
        SizedBox(
          height: 30,
        ),
        BlocBuilder<AllorderrBloc, AllorderrState>(
          builder: (context, state) {
            if (state is AllOrdersSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is SearchDataSccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            }
            return Text(
              "Showing 1 to 5 of 5 entries",
              style: TextStyle(
                color: Colors.black45,
              ),
            );
          },
        ),
        SizedBox(
          height: 30,
        ),
        BlocBuilder<AllorderrBloc, AllorderrState>(
          builder: (context, state) {
            // print("data---container---2");
            // print(ordersBloc);
            // print(addClientBloc);
            // print(bloc);
            if (state is AllorderrInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AllOrderrLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AllOrdersSuccessState) {
              dataAllOrder = state.allorderdata;
              if (state.allorderdata.isNotEmpty) {
                total = state.allorderdata.length;
              }

              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.allorderdata.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
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
                                    "${state.allorderdata[index].createdAt}"),
                            buildrowData(
                              text: 'ORDER',
                              dateApi:
                                  "${state.allorderdata[index].orderNumber}",
                            ),
                            buildrowData(
                                text: 'CLIENT ',
                                dateApi:
                                    "${state.allorderdata[index].client!.firstName} ${state.allorderdata[index].client!.lastName}"),
                            buildrowData(
                                text: 'TOTAL',
                                dateApi: "${state.allorderdata[index].total}"),
                            buildrowData(
                              text: 'PAID AMOUNT',
                              dateApi:
                                  "${state.allorderdata[index].amountPaid}",
                            ),
                            buildrowData(
                              text: 'DEBT',
                              dateApi:
                                  "${state.allorderdata[index].amountRemaining}",
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
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PdafScreen(state
                                                        .allorderdata[index]
                                                        .id)));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        print(
                                            "orders data:${state.allorderdata[index].id}");
                                        // AddClientBloc addCBloc =
                                        //     BlocProvider.of<AddClientBloc>(
                                        //         context);
                                        // OrdersBloc oBloc =
                                        //     BlocProvider.of<OrdersBloc>(
                                        //         context);
                                        // AllorderrBloc bloc =
                                        //     BlocProvider.of<AllorderrBloc>(
                                        //         context);
                                        if (state.allorderdata[index].client !=
                                            null) {
                                          print(
                                              "--------invoked data--container ---120");
                                          // print(jsonEncode(state
                                          //     .allorderdata[index].client!));
                                          addClientBloc.add(ClientDisplayEvent(
                                              client: state.allorderdata[index]
                                                  .client!));
                                          print("111");
                                          ordersBloc.add(ClientAddEvent(
                                              client: state.allorderdata[index]
                                                  .client!));
                                          print("222");

                                          ordersBloc.add(AddPaymentWhenEvent(
                                              when: 'later'));

                                          print("333");

                                          ordersBloc.add(
                                            SetRequestEvent(
                                              request: Request(
                                                id: state
                                                    .allorderdata[index].id,
                                                amountPaid: double.parse(state
                                                        .allorderdata[index]
                                                        .amountPaid)
                                                    .round(),
                                                //double.parse(state.allorderdata[index].amountRemaining).round()
                                                amountRemaining: double.parse(
                                                        state
                                                            .allorderdata[index]
                                                            .amountRemaining)
                                                    .toInt(),
                                                transactionId: "4545",
                                                paymentWhen: 'later',
                                                paymentMethod: "wallet",
                                                typeOfWallet: "smilepay",
                                                cart: [],
                                                cartItem: [],
                                                clientId: state
                                                    .allorderdata[index]
                                                    .clientId,
                                                addressId: state
                                                    .allorderdata[index]
                                                    .client
                                                    ?.orders?[0]
                                                    .addressId,
                                                total: 0,
                                              ),
                                            ),
                                          );
                                          print("444");

                                          ordersBloc.add(
                                            FetchOrderToBeUpdated(
                                              id: state.allorderdata[index].id
                                                  .toString(),
                                            ),
                                          );
                                          print("555");

                                          Navigator.pushNamed(
                                            context,
                                            UpdateOrder.routeName,
                                            arguments:
                                                state.allorderdata[index],
                                          );
                                        }
                                      },
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
                ),
              );
            } else if (state is SearchAllOrderLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AllorderrErrorState) {
              return ErrorWidget(state.message.toString());
            } else if (state is SearchDataSccessState) {
              searchdataAllOrder = state.searchallorderdata;
              if (state.searchallorderdata.isNotEmpty) {
                total = state.searchallorderdata.length;
              }

              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.searchallorderdata.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
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
                                    "${state.searchallorderdata[index].createdAt}"),
                            buildrowData(
                                text: 'ORDER',
                                dateApi:
                                    "${state.searchallorderdata[index].orderNumber}"),
                            buildrowData(
                                text: 'CLIENT ',
                                dateApi:
                                    "${state.searchallorderdata[index].client!.firstName} ${state.searchallorderdata[index].client!.lastName}"),
                            buildrowData(
                                text: 'TOTAL',
                                dateApi:
                                    "${state.searchallorderdata[index].total}"),
                            buildrowData(
                              text: 'PAID AMOUNT',
                              dateApi:
                                  "${state.searchallorderdata[index].amountPaid}",
                            ),
                            buildrowData(
                              text: 'DEBT',
                              dateApi:
                                  "${state.searchallorderdata[index].amountRemaining}",
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
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PdafScreen(state
                                                        .searchallorderdata[
                                                            index]
                                                        .id)));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
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
                ),
              );
            }
            return Container();
          },
        ),
      ],
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 17,
            width: 150,
            child: Text(
              dateApi,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
}
