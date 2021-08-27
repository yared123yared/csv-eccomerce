import 'package:app/Blocs/reports/CollectionReport_cubit/bloc/collection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainerColl extends StatefulWidget {
  @override
  _DataContainerCollState createState() => _DataContainerCollState();
}

class _DataContainerCollState extends State<DataContainerColl> {
  late CollectionBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CollectionBloc>(context);
    bloc.add(FeatchCollectionEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        if (state is CollectionInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CollectionLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CollectionSuccessState) {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print("===========");
              print(state.collextions.length);
              print("===========");
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
                        text: 'PAYMENT DATE',
                        // dateApi:
                        //     "${cubit.collectionReportModel.data![index].createdAt}",
                        dateApi: "${state.collextions[index].createdAt}",
                      ),
                      buildrowData(
                        text: 'PAYMENT METHOD',
                        // dateApi:
                        //     "${cubit.collectionReportModel.data![index].paymentMethod}",
                        dateApi: "${state.collextions[index].paymentMethod}",
                      ),
                      buildrowData(
                        text: 'ORDER',
                        // dateApi:
                        //     "${cubit.collectionReportModel.data![index].order!.orderNumber}",
                        dateApi:
                            "${state.collextions[index].order!.orderNumber}",
                      ),
                      buildrowData(
                        text: 'CLIENT NAME',
                        // dateApi:
                        //     '${cubitData![index].order!.client!.firstName} ${cubitData[index].order!.client!.lastName}',
                        dateApi:
                            "${state.collextions[index].order!.client!.firstName} ${state.collextions[index].order!.client!.lastName}",
                      ),
                      buildrowData(
                        text: 'PAID AMOUNT',
                        // dateApi:
                        //     "${cubit.collectionReportModel.data![index].amountPaid}",
                        dateApi:
                            "${state.collextions[index].amountPaid}",
                      ),
                      buildrowData(
                        text: 'STATUS',
                        // dateApi:
                        //     '${cubit.collectionReportModel.data![index].status}',
                        dateApi: "${state.collextions[index].status}",
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
            itemCount: state.collextions.length,
          );
        } else if (state is CollectionErrorState) {
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
