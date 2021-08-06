// import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
// import 'package:app/Widget/Home/product-item/product-item.dart';
// import 'package:flutter/material.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

// class ProductGrid extends StatelessWidget {
//   ProductState state;
//   ProductBloc productBloc;
//   ProductGrid({required this.state, required this.productBloc});

//   @override
//   Widget build(BuildContext context) {
//     return LazyLoadScrollView(
//       onEndOfPage: () {},
//       child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.6,
//             mainAxisExtent: MediaQuery.of(context).size.width * 0.75,
//           ),
//           itemCount: state.products.length,
//           itemBuilder: (BuildContext ctx, index) {
//             return ProductItem(
//                 product: state.products[index],
//                 onTapped: () =>
//                     productBloc.add(AddProduct(id: state.products[index].id)));
//           }),
//     );
//   }
// }
