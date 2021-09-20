import 'package:app/Blocs/orderDrawer/AllOrderDetails/bloc/allorderdetails_bloc.dart';
import 'package:app/Widget/Home/cart/image.dart';
import 'package:app/Widget/Home/cart/price.dart';
import 'package:app/Widget/Home/cart/title.dart';
import 'package:app/constants/constants.dart';
import 'package:app/language/bloc/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOrderDetailsScreen extends StatefulWidget {
  static const routeName = "/allOrdersDetails";
  final int ide;

  const AllOrderDetailsScreen(this.ide);

  @override
  _AllOrderDetailsScreenState createState() => _AllOrderDetailsScreenState();
}

class _AllOrderDetailsScreenState extends State<AllOrderDetailsScreen> {
  late AllorderdetailsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AllorderdetailsBloc>(context);
    bloc.add(FeatchOrderDetailsEvent(widget.ide));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          cubit.tOrderDetails(),
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<AllorderdetailsBloc, AllorderdetailsState>(
            builder: (context, state) {
              if (state is AllorderdetailsInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrderDetailsALoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrderDetailsASuccessState) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      String imagePath = "https://csv.jithvar.com/storage/";
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 1,
                            color: Colors.white,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.005),
                              child: Row(
                                children: [
                                  LeadingImage(
                                      image:
                                          "${imagePath}${state.orderDetailsAll.products[index].product!.photos[index].filePath}"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ProductTitle(
                                                name: state
                                                    .orderDetailsAll
                                                    .products[index]
                                                    .product!
                                                    .name),

                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            // Text("${product.name}"),
                                            // ProductCategory(
                                            //     productCategory: state
                                            //         .orderDetailsAll
                                            //         .products[index]
                                            //         .product!
                                            //         .categories[index]
                                            //         .name),

                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            ProductPrice(
                                                productPrice: state
                                                    .orderDetailsAll
                                                    .products[index]
                                                    .price),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0001),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ),
                                                  // ProductAmount(
                                                  //   amount: 100,
                                                  // ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ),
                                                ]),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: state.orderDetailsAll.products.length,
                  ),
                );
              } else if (state is OrderDetailsAErrorState) {
                return ErrorWidget(state.error.toString());
              }
              return Container();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ToTal",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<AllorderdetailsBloc, AllorderdetailsState>(
                      builder: (context, state) {
                        if (state is AllorderdetailsInitial) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is OrderDetailsALoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is OrderDetailsASuccessState) {
                          return Text(
                            "\$${state.orderDetailsAll.total}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return Text(
                          "\$0",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
