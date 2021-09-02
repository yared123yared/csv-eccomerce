import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/screens/cart_screens/update_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class DataContainerAllOrders extends StatefulWidget {
  @override
  _DataContainerAllOrdersState createState() => _DataContainerAllOrdersState();
}

class _DataContainerAllOrdersState extends State<DataContainerAllOrders> {
  late AllorderrBloc bloc;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    bloc = BlocProvider.of<AllorderrBloc>(context);
    bloc.add(FeatcAllorderrEvent());

    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //         bloc.fatechFive();
    //       }
    // });
  }

  @override
  void dispose() {
    bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllorderrBloc, AllorderrState>(
      builder: (context, state) {
        if (state is AllorderrInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AllOrderrLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AllOrdersSuccessState) {
          return ListView.separated(
            //controller: _scrollController,
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
                          dateApi: "${state.allorderdata[index].createdAt}"),
                      buildrowData(
                        text: 'ORDER',
                        dateApi: "${state.allorderdata[index].orderNumber}",
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
                        dateApi: "${state.allorderdata[index].amountPaid}",
                      ),
                      buildrowData(
                        text: 'DEBT',
                        dateApi: "${state.allorderdata[index].amountRemaining}",
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
                                  PDF().cachedFromUrl(
                                      "https://csv.jithvar.com/storage/invoices/invoice_1630440878.pdf");
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
            itemCount: state.allorderdata.length,
          );
        } else if (state is SearchAllOrderLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SearchDataSccessState) {
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
                          // dateApi:
                          //     "${cubit.allOrdersModel.data![index].createdAt}",
                          dateApi:
                              "${state.searchallorderdata[index].createdAt}"),
                      buildrowData(
                          text: 'ORDER',
                          // dateApi:
                          //     "${cubit.allOrdersModel.data![index].orderNumber}",
                          dateApi:
                              "${state.searchallorderdata[index].orderNumber}"),
                      buildrowData(
                          text: 'CLIENT ',
                          // dateApi:
                          //     "${cubitData![index].client!.firstName} ${cubitData[index].client!.lastName}",
                          dateApi:
                              "${state.searchallorderdata[index].client!.firstName} ${state.searchallorderdata[index].client!.lastName}"),
                      buildrowData(
                          text: 'TOTAL',
                          //dateApi: '${cubit.allOrdersModel.data![index].total}',
                          dateApi: "${state.searchallorderdata[index].total}"),
                      buildrowData(
                        text: 'PAID AMOUNT',
                        // dateApi:
                        //     '${cubit.allOrdersModel.data![index].amountPaid}',
                        dateApi:
                            "${state.searchallorderdata[index].amountPaid}",
                      ),
                      buildrowData(
                        text: 'DEBT',
                        // dateApi: '${cubitData[index].client!.debts}',
                        dateApi:
                            "${state.searchallorderdata[index].amountRemaining}",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                onPressed: () {
                                  // print("orders data:${ state.allorderdata[index].id}");
                                  Navigator.pushNamed(
                                      context, UpdateOrder.routeName,
                                      arguments: state.searchallorderdata[index]);
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
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: state.searchallorderdata.length,
          );
        } else if (state is AllorderrErrorState) {
          return ErrorWidget(state.message.toString());
        }
        return Container();
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
