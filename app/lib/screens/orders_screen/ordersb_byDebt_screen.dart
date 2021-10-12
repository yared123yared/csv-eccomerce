import 'package:app/Blocs/currency/bloc/currencysymbol_bloc.dart';
import 'package:app/Blocs/orderDrawer/OrderByDebt/bloc/orderbydebt_bloc.dart';
import 'package:app/Widget/Orders/orderbyDebt/data_container.dart';
import 'package:app/Widget/Orders/orderbyDebt/search_container.dart';
import 'package:app/constants/constants.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:app/models/OrdersDrawer/orderbyDebt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../drawer.dart';

class OrdersByDebtScreen extends StatefulWidget {
  static const routeName = "/orderByDebtScreen";

  @override
  _OrdersByDebtScreenState createState() => _OrdersByDebtScreenState();
}

class _OrdersByDebtScreenState extends State<OrdersByDebtScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<DataOrderByDebt> orderByDebtdata = [];

  late OrderbydebtBloc bloc;
  late CurrencySymbolbloc blocs;

  @override
  void initState() {
    bloc = BlocProvider.of<OrderbydebtBloc>(context);
    bloc.add(FeatchOrderbydebtEvent());
    blocs = BlocProvider.of<CurrencySymbolbloc>(context);
    blocs.add(FeatchCurrencysymbolEvent());
    // bloc.add(grandTotalEvent());

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            height: 5.0,
            width: 5.0,
            child: ImageIcon(
              AssetImage('assets/images/left-align.png'),
            ),
          ),
        ),
        title: Text(
          cubit.tOrdersByDebt(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        onPressed: () {},
      ),
      drawerEnableOpenDragGesture: true,
      backgroundColor: lightColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            child: SearchOrderBtDebt(),
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<OrderbydebtBloc, OrderbydebtState>(
            builder: (context, state) {
              if (state is OrderbydebtSuccessState) {
                return Text(
                  "${cubit.tshowing()} 1 ${cubit.tTo()} 5 ${cubit.tOf()} ${state.orderbydept.length} ${cubit.tentries()}",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                );
              } else if (state is SearchOrderByDebtSccessState) {
                return Text(
                  "${cubit.tshowing()} 1 ${cubit.tTo()} 5 ${cubit.tOf()} ${state.searchOrderByDebt.length} ${cubit.tentries()}",
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
            height: 30,
          ),
          Expanded(
            child: DataContainerOrderByDebt(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Container(
              width: 400,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: BlocBuilder<OrderbydebtBloc, OrderbydebtState>(
                    builder: (context, state) {
                  if (state is OrderbydebtSuccessState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            buildTextSymbol(text: "\$ ${state.grandTotalInt.sum}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: cubit.tDEBT()),
                            buildTextSymbol(text: "\$ ${state.debtTotalInt.sum}")
                          ],
                        ),
                      ],
                    );
                  } else if (state is SearchOrderByDebtSccessState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            buildTextSymbol(
                                text: "\$ ${state.searchgrandTotalInt.sum}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: cubit.tDEBT()),
                            buildTextSymbol(
                                text: "\$ ${state.searchdebtTotalInt.sum}")
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: "GRAND TOTAL"),
                            
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(text: cubit.tDEBT()),
                           
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText({required String text}) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
  Widget buildTextSymbol({required String text}) =>
      BlocBuilder<CurrencySymbolbloc, CurrencysymbolState>(
        builder: (context, state) {
          if (state is CurrencysymbolLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CurrencysymbolSuccessState) {
            return Text(
              "${state.symbolModel.symbol} $text",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            );
          }
          return Container();
        },
      );
}
