import 'dart:convert';
import 'package:app/Blocs/orderDrawer/OrderByDebt/orderByDebt_state.dart';
import 'package:app/models/OrdersDrawer/orderbyDebt_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

class OrderByDebtCubit extends Cubit<OrderByDebtState> {
  final UserPreferences userPreferences;
  OrderByDebtCubit(this.userPreferences) : super(OrderByDebtInitialState());

  static OrderByDebtCubit get(BuildContext context) => BlocProvider.of(context);

  bool isComeData = false;
  bool isComeDataWrong = false;

  late OrderByDebtModel orderByDebtModel;

  List<String> grandTotalString = [];
  List<double> grandTotalInt = [];
  List<String> debtTotalString = [];
  List<double> debtTotalInt = [];
  late OrderByDebtModel sumofnuber;
  Future featchTotalDebt() async {
    String? token = await this.userPreferences.getUserToken();
    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/debts');
      final response = await http.post(url,
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
              "amount_remaining",
              "actions"
            ],
            "draw": 0,
            "length": 10,
            "search": "",
            "column": 0,
            "field": "",
            "relationship": false,
            "relationship_field": "",
            "dir": "desc"
          }));
      if (response.statusCode == 200) {
        ;

        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders'];

        sumofnuber = OrderByDebtModel.fromJson(data);

        for (int i = 0; i < sumofnuber.data!.length; i++) {
          grandTotalString.add(sumofnuber.data![i].total);
          debtTotalString.add(sumofnuber.data![i].amountRemaining);
        }
        grandTotalInt = grandTotalString.map(double.parse).toList();
        debtTotalInt = debtTotalString.map(double.parse).toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }

    emit(ListNumbersOfOrderDebt());
  }

  TextEditingController searchController = TextEditingController();

  Future postOrdersByDebt() async {
    String? token = await this.userPreferences.getUserToken();

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/debts');
      final response = await http.post(url,
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
              "amount_remaining",
              "actions"
            ],
            "draw": 0,
            "length": 10,
            "search": "",
            "column": 0,
            "field": "",
            "relationship": false,
            "relationship_field": "",
            "dir": "desc"
          }));
      if (response.statusCode == 200) {
        isComeData = true;
        isComeDataWrong = false;

        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders'];

        orderByDebtModel = OrderByDebtModel.fromJson(data);
      } else {
        isComeData = false;
        isComeDataWrong = true;
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    emit(FeatchDataSucessState());
  }

  //Search api here

  List<String> seardhgrandTotalString = [];
  List<double> searchgrandTotalInt = [];
  List<String> searchdebtTotalString = [];
  List<double> searchdebtTotalInt = [];

  Future postOrdersByDebtSearch({required String searchName}) async {
    String? token = await this.userPreferences.getUserToken();

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/debts');
      final response = await http.post(url,
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
              "amount_remaining",
              "actions"
            ],
            "draw": 0,
            "length": 10,
            "search": searchName,
            "column": 0,
            "field": "client",
            "relationship": true,
            "relationship_field": "first_name",
            "dir": "desc"
          }));
      if (response.statusCode == 200) {
        isComeData = true;
        isComeDataWrong = false;

        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders'];

        orderByDebtModel = OrderByDebtModel.fromJson(data);

        // for (int i = 0; i < sumofnuber.data!.length; i++) {
        //   seardhgrandTotalString.add(sumofnuber.data![i].total);
        //   searchdebtTotalString.add(sumofnuber.data![i].amountRemaining);
        //   emit(ListNumbersOfOrderDebt());
        // }
        // searchgrandTotalInt = seardhgrandTotalString.map(double.parse).toList();
        // searchdebtTotalInt = searchdebtTotalString.map(double.parse).toList();

        //  print("Walid : ${orderByDebtModel.data![0].status}");
      } else {
        isComeData = false;
        isComeDataWrong = true;

        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    emit(FeatchDataSucessState());
  }
}
