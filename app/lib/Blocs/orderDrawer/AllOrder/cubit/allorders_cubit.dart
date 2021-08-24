import 'dart:async';
import 'dart:convert';

import 'package:app/Blocs/orderDrawer/AllOrder/cubit/allorders_state.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AllOrdersCubit extends Cubit<AllOredersState> {
  final UserPreferences userPreferences;

  AllOrdersCubit(this.userPreferences) : super(AllOrderInitiallState());

  static AllOrdersCubit get(BuildContext context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  bool isComeData = false;
  bool isComeDataWrong = false;
  late AllOrdersModel allOrdersModel;

  // Future postAllOrders({required String searchNmae}) async {
  //   String? token = await this.userPreferences.getUserToken();

  //   try {
  //     final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/all');
  //     final response = await http.post(url,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: jsonEncode({
  //           "tableColumns": [
  //             "created_at",
  //             "order_number",
  //             "client",
  //             "total",
  //             "amount_paid",
  //             "amount_remaining",
  //             "actions"
  //           ],
  //           "draw": 0,
  //           "length": 10,
  //           "search": searchNmae,
  //           "column": 0,
  //           "field": "",
  //           "relationship": false,
  //           "relationship_field": "",
  //           "dir": "desc"
  //         }));
  //     if (response.statusCode == 200) {
  //       isComeData = true;
  //       isComeDataWrong = false;
  //       final extractedData =
  //           json.decode(response.body) as Map<String, dynamic>;

  //       final data = extractedData['orders'];

  //       allOrdersModel = AllOrdersModel.fromJson(data);
  //       // print("Walid : ${allOrdersModel.data![0].total}");
  //     } else {
  //       isComeData = false;
  //       isComeDataWrong = true;
  //       throw Exception('Failed to load courses');
  //     }
  //   } catch (e) {
  //     print("Exception throuwn $e");
  //   }
  //   emit(FeatchDataSucessState());
  // }

  //search apis here

  Future postAllSearchOrders({required String searchNmae}) async {
    String? token = await this.userPreferences.getUserToken();

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/all');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "tableColumns": [
            "created_at",
            "order_number",
            "client",
            "total",
            "amount_paid",
            "amount_remaining",
            "actions"
          ],
          "draw": 0,
          "length": 10,
          "search": searchNmae,
          "column": 0,
          "field": "client",
          "relationship": true,
          "relationship_field": "first_name",
          "dir": "desc"
        }),
      );
      Timer(Duration(seconds: 1), () {
        if (response.statusCode == 200) {
          isComeData = true;
          isComeDataWrong = false;
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['orders'];

          allOrdersModel = AllOrdersModel.fromJson(data);
         // print("Walid roaa doaa : ${allOrdersModel.data!.length}");
        } else {
          isComeData = false;
          isComeDataWrong = true;
          throw Exception('Failed to load courses');
        }
      });
    } catch (e) {
      print("Exception throuwn $e");
    }
    emit(FeatchDataSucessState());
  }
}
