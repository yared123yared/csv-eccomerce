import 'package:app/Blocs/orderDrawer/OrderByDebt/bloc/orderbydebt_bloc.dart';
import 'package:app/Widget/Orders/allOrders/Pdf/pdf_screen.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataContainerOrderByDebt extends StatefulWidget {
  @override
  _DataContainerOrderByDebtState createState() =>
      _DataContainerOrderByDebtState();
}

class _DataContainerOrderByDebtState extends State<DataContainerOrderByDebt> {
  late OrderbydebtBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<OrderbydebtBloc>(context);
    bloc.add(FeatchOrderbydebtEvent());
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
    return BlocBuilder<OrderbydebtBloc, OrderbydebtState>(
      builder: (context, state) {
        if (state is OrderbydebtInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OrderbydebtLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OrderbydebtSuccessState) {
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
                          text: cubit.tDATE(),
                          dateApi: "${state.orderbydept[index].createdAt}"),
                      buildrowData(
                        text: cubit.tORDER(),
                        dateApi: "${state.orderbydept[index].orderNumber}",
                      ),
                      buildrowData(
                          text: cubit.tCLIENT(),
                          dateApi:
                              "${state.orderbydept[index].client!.firstName} ${state.orderbydept[index].client!.lastName}"),
                      buildrowData(
                          text: cubit.tTOTAL(),
                          dateApi: '${state.orderbydept[index].total}'),
                      buildrowData(
                          text: cubit.tDEBT(),
                          dateApi:
                              '${state.orderbydept[index].amountRemaining}'),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PdafScreen(
                                          state.orderbydept[index].id)));
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
            itemCount: state.orderbydept.length,
          );
        } else if (state is SearchOrderByDebtLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SearchOrderByDebtSccessState) {
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
                          text: cubit.tDATE(),
                          dateApi:
                              "${state.searchOrderByDebt[index].createdAt}"),
                      buildrowData(
                        text: cubit.tORDER(),
                        dateApi:
                            "${state.searchOrderByDebt[index].orderNumber}",
                      ),
                      buildrowData(
                          text: cubit.tCLIENT(),
                          dateApi:
                              "${state.searchOrderByDebt[index].client!.firstName} ${state.searchOrderByDebt[index].client!.lastName}"),
                      buildrowData(
                          text: cubit.tTOTAL(),
                          dateApi: '${state.searchOrderByDebt[index].total}'),
                      buildrowData(
                          text: cubit.tDEBT(),
                          dateApi:
                              '${state.searchOrderByDebt[index].amountRemaining}'),
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
                                onPressed: () {},
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
            itemCount: state.searchOrderByDebt.length,
          );
        } else if (state is OrderbydebtErrorState) {
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
