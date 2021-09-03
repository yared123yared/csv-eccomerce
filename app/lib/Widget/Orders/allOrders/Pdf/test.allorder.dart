// import 'package:app/Blocs/PDF/bloc/pdf_bloc.dart';
// import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
// import 'package:app/Widget/Orders/allOrders/Pdf/pdf_screen.dart';
// import 'package:app/Widget/Orders/allOrders/search_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class DataContainerAllOrders extends StatefulWidget {
//   @override
//   _DataContainerAllOrdersState createState() => _DataContainerAllOrdersState();
// }

// class _DataContainerAllOrdersState extends State<DataContainerAllOrders> {
//   late AllorderrBloc bloc;

//   ScrollController _scrollController = ScrollController();
//   final ItemPositionsListener itemPositionsListener =
//       ItemPositionsListener.create();
//   final ItemScrollController itemScrollController = ItemScrollController();

//   @override
//   void initState() {
//     bloc = BlocProvider.of<AllorderrBloc>(context);
//     bloc.add(FeatcAllorderrEvent());

//     super.initState();
//   }

//   @override
//   void dispose() {
//     bloc.close();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
//           child: SearchContinerAllOrder(),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         BlocBuilder<AllorderrBloc, AllorderrState>(
//           builder: (context, state) {
//             if (state is AllOrdersSuccessState) {
//               return Text(
//                 "Showing 1 to 5 of ${state.allorderdata.length} entries",
//                 style: TextStyle(
//                   color: Colors.black45,
//                 ),
//               );
//             } else if (state is SearchDataSccessState) {
//               return Text(
//                 "Showing 1 to 5 of ${state.searchallorderdata.length} entries",
//                 style: TextStyle(
//                   color: Colors.black45,
//                 ),
//               );
//             }
//             return Text(
//               "Showing 1 to 5 of 5 entries",
//               style: TextStyle(
//                 color: Colors.black45,
//               ),
//             );
//           },
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         BlocBuilder<AllorderrBloc, AllorderrState>(
//           builder: (context, state) {
//             if (state is AllorderrInitial) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is AllOrderrLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is AllOrdersSuccessState) {
//               return Expanded(
//                 child: ListView.separated(
//                   physics: ScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Container(
//                         width: 400,
//                         height: 230,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             buildrowData(
//                                 text: 'DATE',
//                                 dateApi:
//                                     "${state.allorderdata[index].createdAt}"),
//                             buildrowData(
//                               text: 'ORDER',
//                               dateApi:
//                                   "${state.allorderdata[index].orderNumber}",
//                             ),
//                             buildrowData(
//                                 text: 'CLIENT ',
//                                 dateApi:
//                                     "${state.allorderdata[index].client!.firstName} ${state.allorderdata[index].client!.lastName}"),
//                             buildrowData(
//                                 text: 'TOTAL',
//                                 dateApi: "${state.allorderdata[index].total}"),
//                             buildrowData(
//                               text: 'PAID AMOUNT',
//                               dateApi:
//                                   "${state.allorderdata[index].amountPaid}",
//                             ),
//                             buildrowData(
//                               text: 'DEBT',
//                               dateApi:
//                                   "${state.allorderdata[index].amountRemaining}",
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: Color(0xff48c2d5),
//                                     foregroundColor: Colors.white,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         Icons.print,
//                                         color: Colors.white,
//                                       ),
//                                       onPressed: () {
//                                         BlocProvider.of<PdfBloc>(context).add(
//                                             FeatchPdfEvent(
//                                                 state.allorderdata[index].id));
//                                         Navigator.of(context)
//                                             .pushNamed(PdafScreen.routeName);
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   CircleAvatar(
//                                     backgroundColor:
//                                         Theme.of(context).primaryColor,
//                                     foregroundColor: Colors.white,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         Icons.edit,
//                                         color: Colors.white,
//                                       ),
//                                       onPressed: () {},
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return SizedBox(
//                       height: 20,
//                     );
//                   },
//                   itemCount: state.allorderdata.length,
//                 ),
//               );
//             } else if (state is SearchAllOrderLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is AllorderrErrorState) {
//               return ErrorWidget(state.message.toString());
//             } else if (state is SearchDataSccessState) {
//               return ListView.separated(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 10, right: 10),
//                     child: Container(
//                       width: 400,
//                       height: 230,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           buildrowData(
//                               text: 'DATE',
//                               dateApi:
//                                   "${state.searchallorderdata[index].createdAt}"),
//                           buildrowData(
//                               text: 'ORDER',
//                               dateApi:
//                                   "${state.searchallorderdata[index].orderNumber}"),
//                           buildrowData(
//                               text: 'CLIENT ',
//                               dateApi:
//                                   "${state.searchallorderdata[index].client!.firstName} ${state.searchallorderdata[index].client!.lastName}"),
//                           buildrowData(
//                               text: 'TOTAL',
//                               dateApi:
//                                   "${state.searchallorderdata[index].total}"),
//                           buildrowData(
//                             text: 'PAID AMOUNT',
//                             dateApi:
//                                 "${state.searchallorderdata[index].amountPaid}",
//                           ),
//                           buildrowData(
//                             text: 'DEBT',
//                             dateApi:
//                                 "${state.searchallorderdata[index].amountRemaining}",
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 CircleAvatar(
//                                   backgroundColor:
//                                       Theme.of(context).primaryColor,
//                                   foregroundColor: Colors.white,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.edit,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {},
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return SizedBox(
//                     height: 20,
//                   );
//                 },
//                 itemCount: state.searchallorderdata.length,
//               );
//             }
//             return Container();
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildrowData({
//     required String text,
//     required String dateApi,
//   }) =>
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 12,
//               left: 10,
//             ),
//             child: Container(
//               height: 17,
//               width: 150,
//               color: Colors.white,
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 17,
//             width: 150,
//             child: Text(
//               dateApi,
//               style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       );
// }
