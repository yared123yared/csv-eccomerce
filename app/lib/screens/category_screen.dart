import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/product-category/productCategory.dart';
import 'package:app/Widget/Home/product-item/product-item.dart';
import 'package:app/Widget/Home/search-bar/searchBar.dart';
import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class CategoryScreen extends StatefulWidget {
  static const routeName = 'home';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late ProductBloc productBloc;

  @override
  void init() {
    print("This is the init step");
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(FetchProduct());
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        // bottomNavigationBar: HomeBottomNavigation(),
        body: Container(
            color: Color(0xFFf2f6f9),
            child: Column(children: [
              SearchBar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCategory(title: "All"),
                      ProductCategory(
                        title: "Shoes",
                      ),
                      ProductCategory(title: "Phone"),
                      ProductCategory(title: "Chair"),
                      ProductCategory(title: "Watch"),
                      ProductCategory(title: "All"),
                      ProductCategory(
                        title: "Shoes",
                      ),
                      ProductCategory(title: "Phone"),
                      ProductCategory(title: "Chair"),
                      ProductCategory(title: "Watch"),
                    ],
                  ),
                ),
              ),
              Expanded(child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                print("Entered to the bloc builder");
                if (state is ProductLoadSuccess) {
                  print("load sucess");
                  print(state.products.length);
                  return LazyLoadScrollView(
                      onEndOfPage: () {},
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.6,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.35,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                                child: ProductItem(
                                    product: state.products[index]));
                          }));
                } else if (state is ProductLoading) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()));
                  // ProductLoading

                } else if (state is ProductOperationFailure) {
                  print(state.message);
                }
                return Container();
              }))
              // return Container();
            ])));
  }
}
