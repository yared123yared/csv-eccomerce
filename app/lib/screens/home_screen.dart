import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Widget/Home/bottom-navigation/bottomNavigation.dart';
import 'package:app/Widget/Home/product-category/productCategory.dart';
import 'package:app/Widget/Home/product-item/product-item.dart';
import 'package:app/Widget/Home/search-bar/searchBar.dart';
import 'package:app/models/product/data.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import '../constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatelessWidget {
  late ProductBloc productBloc;

  @override
  void init() {
    print("This is the init step");
    // super.initState();
  }

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(FetchProduct());
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('CSV'),
          backgroundColor: primaryColor,
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Container(
              height: 5.0,
              width: 5.0,
              child: ImageIcon(
                AssetImage('assets/images/left-align.png'),
              ),
            ),
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor:
                primaryColor, //This will change the drawer background to blue.
            //other styles
          ),
          child: Profile(),
        ),
        drawerEnableOpenDragGesture: true,
        bottomNavigationBar: HomeBottomNavigation(),
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
                    // ProductLoadSuccess
                    print("fetched sucessfully");
                    // print(state.products);
                    for (int i = 0; i < state.products.length; i++) {
                      print(state.products[i].name);
                    }
                    return LazyLoadScrollView(
                      onEndOfPage: () {
                        if (state is ProductLoading) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Loading"),
                          ));
                        }
                        if (state is ProductLoadSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Successfully loaded"),
                          ));
                          if (state is ProductOperationFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("There is no data"),
                            ));
                          }
                        }
                      },
                      child: GridView.builder(
                          //                  width: MediaQuery.of(context).size.width * 0.5,
                          // height: MediaQuery.of(context).size.width * 0.7,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.6,
                            mainAxisExtent:
                                MediaQuery.of(context).size.width * 0.7,
                            // childAspectRatio: 3 / 2,
                            // crossAxisSpacing: 40,
                            // mainAxisSpacing: 40
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ProductItem(
                              name: state.products[index].name.toString(),
                              image: state.products[index].photos![0].filePath
                                  .toString(),
                            );
                          }),
                    );
                    // return ListView.separated(
                    //     itemBuilder: (context, index) {
                    //       // return Row(
                    //       //   children: [
                    //       //     ProductItem(
                    //       //       name: state.products[index].name.toString(),
                    //       //       image: state.products[index].photos![0].filePath
                    //       //           .toString(),
                    //       //     ),
                    //       //     ProductItem(
                    //       //       name: state.products[index + 1].name.toString(),
                    //       //       image: state.products[index].photos![0].filePath
                    //       //           .toString(),
                    //       //     ),
                    //       //   ],
                    //       // );
                    //       return GridView(

                    //         scrollDirection: Axis.horizontal,
                    //         gridDelegate:
                    //             SliverGridDelegateWithMaxCrossAxisExtent(

                    //                 maxCrossAxisExtent: 200,
                    //                 childAspectRatio: 3 / 2,
                    //                 crossAxisSpacing: 20,
                    //                 mainAxisSpacing: 20),
                    //         children: [
                    //           // Some widgets
                    //         ],
                    //       );
                    //     },
                    //     separatorBuilder: (context, index) => Divider(),
                    //     itemCount: state.products.length);
                  } else if (state is ProductLoading) {
                    // ProductLoading
                    print("loading to fetch the data");
                  } else if (state is ProductOperationFailure) {
                    print(state.message);
                  } else {
                    // error
                    print("error");
                  }
                  return Container();
                },
              )
                  // child: SingleChildScrollView(
                  //   scrollDirection: Axis.vertical,
                  //   child: Column(
                  //     children: [
                  //       SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           children: [
                  //             ProductItem(),
                  //             ProductItem(),
                  //           ],
                  //         ),
                  //       ),
                  //       SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           children: [
                  //             ProductItem(),
                  //             ProductItem(),
                  //           ],
                  //         ),
                  //       ),
                  //       SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           children: [
                  //             ProductItem(),
                  //             ProductItem(),
                  //           ],
                  //         ),
                  //       ),
                  //       SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           children: [
                  //             ProductItem(),
                  //             ProductItem(),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  ),
            ])));
  }
}
