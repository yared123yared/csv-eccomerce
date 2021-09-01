import 'dart:convert';

import 'package:app/Blocs/reports/CustomerDebt/cubit/customer_state.dart';
import 'package:app/models/repoets_model/custom_report_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CustomerDebtCubit extends Cubit<CustomerDebttState> {
  final UserPreferences userPreferences;
  CustomerDebtCubit(
    this.userPreferences,
  ) : super(CustomerDebtInitialState());

  static CustomerDebtCubit get(BuildContext context) =>
      BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  bool isComeData = false;
  bool isComeDataWrong = false;

  late CustomReportModel customReportModel;

  Future postCustomReport() async {
    String? token = await this.userPreferences.getUserToken();

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/clients/debts');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "draw": 0,
            "length": 10,
            "search": "",
            "column": 0,
            "field": "",
            "relationship": false,
            "relationship_field": "",
            "dir": "asc"
          }));
      if (response.statusCode == 200) {
        isComeData = true;
        isComeDataWrong = false;

        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['clients'];

        customReportModel = CustomReportModel.fromJson(data);
        //print("Walid : ${customReportModel.data![0].email}");
      } else {
        isComeData = false;
        isComeDataWrong = true;
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    emit(FeatchDataSucessCollState());
  }

  //Fetach Search Api Here

  bool isSearchCome = false;

  // Future postCustomReportSearch({required String searchClientName}) async {
  //   String? token = await this.userPreferences.getUserToken();

  //   try {
  //     final url = Uri.parse('http://csv.jithvar.com/api/v1/clients/debts');
  //     final response = await http.post(url,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: jsonEncode(
  //           {
  //           "draw": 0,
  //           "length": 10,
  //           "search": searchClientName,
  //           "column": 0,
  //           "field": "first_name",
  //           "relationship": false,
  //           "relationship_field": "",
  //           "dir": "asc"
  //         }
  //         ));
  //     if (response.statusCode == 200) {
  //       isSearchCome = false;

  //       final extractedData =
  //           json.decode(response.body) as Map<String, dynamic>;

  //       final data = extractedData['clients'];

  //       customReportModel = CustomReportModel.fromJson(data);
  //       // print("Walid : ${customReportModel.data![0].email}");
  //       emit(FeatchSearchCollState());
  //     } else {
  //       isSearchCome = true;

  //       throw Exception('Failed to load courses');
  //     }
  //   } catch (e) {
  //     print("Exception throuwn $e");
  //   }
  //   emit(FeatchDataSucessCollState());
  // }
}
