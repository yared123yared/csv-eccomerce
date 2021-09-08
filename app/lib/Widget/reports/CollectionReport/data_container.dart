import 'package:app/Blocs/reports/CollectionReport_cubit/bloc/collection_bloc.dart';
import 'package:app/models/repoets_model/collection_report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataContainerColl extends StatefulWidget {
  @override
  _DataContainerCollState createState() => _DataContainerCollState();
}

class _DataContainerCollState extends State<DataContainerColl> {
  late CollectionBloc bloc;

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  List<DataCollection> dataCollection = [];
  List<DataCollection> searchCollection = [];
  List<DataCollection> fromToCollection = [];

  int start = 0;
  int end = 0;
  int total = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<CollectionBloc>(context);
    bloc.add(FeatchCollectionEvent());
    super.initState();
    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (dataCollection.isNotEmpty) {
              if (dataCollection.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );
    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (searchCollection.isNotEmpty) {
              if (searchCollection.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );
    itemPositionsListener.itemPositions.addListener(
      () {
        final indices = itemPositionsListener.itemPositions.value
            .map((item) => item.index)
            .toList();
        if (indices.length > 0) {
          setState(() {
            if (fromToCollection.isNotEmpty) {
              if (fromToCollection.length > 0) {
                start = indices[0] + 1;
                end = indices.length;
              }
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, state) {
            if (state is CollectionSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is SearchCollectionSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else if (state is FromToCollectionSuccessState) {
              return Text(
                "showing ${start} to ${total} of ${total} entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            } else {
              return Text(
                "Showing 1 to 5 of 5 entries",
                style: TextStyle(
                  color: Colors.black45,
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 15,
        ),
        BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, state) {
            if (state is CollectionInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CollectionLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CollectionSuccessState) {
              dataCollection = state.collextions;
              if (state.collextions.isNotEmpty) {
                total = state.collextions.length;
              }
              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.collextions.length,
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
                              text: 'PAYMENT DATE',
                              dateApi: "${state.collextions[index].createdAt}",
                            ),
                            buildrowData(
                              text: 'PAYMENT METHOD',
                              dateApi:
                                  "${state.collextions[index].paymentMethod}",
                            ),
                            buildrowData(
                              text: 'ORDER',
                              dateApi:
                                  "${state.collextions[index].order!.orderNumber}",
                            ),
                            buildrowData(
                              text: 'CLIENT NAME',
                              dateApi:
                                  "${state.collextions[index].order!.client!.firstName} ${state.collextions[index].order!.client!.lastName}",
                            ),
                            buildrowData(
                              text: 'PAID AMOUNT',
                              dateApi: "${state.collextions[index].amountPaid}",
                            ),
                            buildrowData(
                              text: 'STATUS',
                              dateApi: "${state.collextions[index].status}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is SearchCollectionLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SearchCollectionSuccessState) {
              searchCollection = state.searchCollextions;
              if (state.searchCollextions.isNotEmpty) {
                total = state.searchCollextions.length;
              }
              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.searchCollextions.length,
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
                              text: 'PAYMENT DATE',
                              dateApi:
                                  "${state.searchCollextions[index].createdAt}",
                            ),
                            buildrowData(
                              text: 'PAYMENT METHOD',
                              dateApi:
                                  "${state.searchCollextions[index].paymentMethod}",
                            ),
                            buildrowData(
                              text: 'ORDER',
                              dateApi:
                                  "${state.searchCollextions[index].order!.orderNumber}",
                            ),
                            buildrowData(
                              text: 'CLIENT NAME',
                              dateApi:
                                  "${state.searchCollextions[index].order!.client!.firstName} ${state.searchCollextions[index].order!.client!.lastName}",
                            ),
                            buildrowData(
                              text: 'PAID AMOUNT',
                              dateApi:
                                  "${state.searchCollextions[index].amountPaid}",
                            ),
                            buildrowData(
                              text: 'STATUS',
                              dateApi:
                                  "${state.searchCollextions[index].status}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is FromToCollectionLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FromToCollectionSuccessState) {
              fromToCollection = state.fromTlCollextions;
              if (state.fromTlCollextions.isNotEmpty) {
                total = state.fromTlCollextions.length;
              }
              return Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.fromTlCollextions.length,
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
                              text: 'PAYMENT DATE',
                              dateApi:
                                  "${state.fromTlCollextions[index].createdAt}",
                            ),
                            buildrowData(
                              text: 'PAYMENT METHOD',
                              dateApi:
                                  "${state.fromTlCollextions[index].paymentMethod}",
                            ),
                            buildrowData(
                              text: 'ORDER',
                              dateApi:
                                  "${state.fromTlCollextions[index].order!.orderNumber}",
                            ),
                            buildrowData(
                              text: 'CLIENT NAME',
                              dateApi:
                                  "${state.fromTlCollextions[index].order!.client!.firstName} ${state.fromTlCollextions[index].order!.client!.lastName}",
                            ),
                            buildrowData(
                              text: 'PAID AMOUNT',
                              dateApi:
                                  "${state.fromTlCollextions[index].amountPaid}",
                            ),
                            buildrowData(
                              text: 'STATUS',
                              dateApi:
                                  "${state.fromTlCollextions[index].status}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CollectionErrorState) {
              return ErrorWidget(state.message.toString());
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
            padding: const EdgeInsets.only(top: 8, left: 10),
            child: Container(
              height: 30,
              width: 150,
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 15),
            child: Container(
              height: 30,
              width: 150,
              child: Text(
                dateApi,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
}
