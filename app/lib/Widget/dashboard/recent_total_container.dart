import 'package:app/Blocs/dashBoard/recentOrder/bloc/recent_order_bloc.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoTotalContainer extends StatefulWidget {
  @override
  _InfoTotalContainerState createState() => _InfoTotalContainerState();
}

class _InfoTotalContainerState extends State<InfoTotalContainer> {
  late RecentOrderBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<RecentOrderBloc>(context);
    bloc.add(FeatchRecentOrderEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 44,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<RecentOrderBloc, RecentOrderState>(
        builder: (context, state) {
          if (state is RecentOrderInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecentOrderLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecentOrderSuccessState) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildrowData(
                      text: cubit.tORDERNUMBER(),
                      dateApi: "${state.recentOrder[index].orderNumber}",
                    ),
                    buildrowData(
                      text: cubit.tCLIENT(),
                      dateApi:
                          "${state.recentOrder[index].client!.firstName} ${state.recentOrder[index].client!.lastName}",
                    ),
                    buildrowData(
                      text: cubit.tDATE(),
                      dateApi: "${state.recentOrder[index].createdAt}",
                    ),
                    buildrowData(
                      text: cubit.tTOTAL(),
                      dateApi: "${state.recentOrder[index].total}",
                    ),
                    buildrowData(
                      text: cubit.tDEBT(),
                      dateApi: "${state.recentOrder[index].amountRemaining}",
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 5,
                );
              },
              itemCount: state.recentOrder.length,
            );
          } else if (state is SearchRecentOrderLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchRecentOrderSuccessState) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildrowData(
                      text: cubit.tORDERNUMBER(),
                      dateApi: "${state.searchRecentOrder[index].orderNumber}",
                    ),
                    buildrowData(
                      text: cubit.tCLIENT(),
                      dateApi:
                          "${state.searchRecentOrder[index].client!.firstName} ${state.searchRecentOrder[index].client!.lastName}",
                    ),
                    buildrowData(
                      text: cubit.tDATE(),
                      dateApi: "${state.searchRecentOrder[index].createdAt}",
                    ),
                    buildrowData(
                      text: cubit.tTOTAL(),
                      dateApi: "${state.searchRecentOrder[index].total}",
                    ),
                    buildrowData(
                      text: cubit.tDEBT(),
                      dateApi:
                          "${state.searchRecentOrder[index].amountRemaining}",
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 5,
                );
              },
              itemCount: state.searchRecentOrder.length,
            );
          } else if (state is RecentOrderErrorState) {
            return ErrorWidget(state.error.toString());
          }
          return Container();
        },
      ),
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
              height: 30,
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
            height: 30,
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
