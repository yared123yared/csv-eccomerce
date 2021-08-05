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

class Home extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ProductBloc productBloc;

  @override
  void init() {
    print("This is the init step");
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductItem> productList = [];

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
                  // state.products.map((product) {});
                  for (int i = 0; i < state.products.length; i++) {
                    productList.add(ProductItem(
                        product: state.products[i],
                        onTapped: () {
                          productBloc.add(AddProduct(id: state.products[i].id));
                          // productBloc.add(FetchProduct());
                          // productBloc.add(FetchProduct());
                        }));
                  }
                  // ProductLoadSuccess
                  print("fetched sucessfully");
                  print(
                      "This i the length of the product item ${productList.length}");
                } else if (state is ProductLoading) {
                  // ProductLoading
                  print("loading to fetch the data");
                } else if (state is ProductOperationFailure) {
                  print(state.message);
                } else if (state is ProductUpdated) {
                  // productList = [];
                  for (int i = 0; i < productList.length; i++) {
                    // productList.add(productList[i]);
                    if (productList[i].product.id == state.product.id) {
                      // ProductItem updatedItem = productList[i];

                      productList[i].product = state.product;
                      // productList.add(productList[i]);
                      print(
                          "This is teh product list data ${productList[i].product.order}");
                    }
                    // if (productList[i].key == 1) ;
                  }

                  // updated product will render here.

                  print(
                      "This is he updated value order ${state.product.order}");
                }

                return LazyLoadScrollView(
                    onEndOfPage: () {},
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.6,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.35,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          print(
                              "This is the key for the widget ${productList[index].key}");
                          return Container(child: productList[index]);
                        }));
              })),
            ])));
  }
}
