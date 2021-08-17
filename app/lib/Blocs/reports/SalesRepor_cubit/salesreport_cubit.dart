import 'dart:convert';
import 'package:app/Blocs/reports/SalesRepor_cubit/salesreport_state.dart';
import 'package:app/models/repoets_model/sales_report_models.dart';
import 'package:http/http.dart' as http;

import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesReportCubit extends Cubit<SalesReportState> {
  final UserPreferences userPreferences;
  SalesReportCubit(this.userPreferences) : super(ReportInitialState());

  static SalesReportCubit get(BuildContext context) => BlocProvider.of(context);

  // DateTime

  bool isFormDate = false;
  bool isToDate = false;

  DateTime dateForm = DateTime.now();

  DateTime dateTo = DateTime.now();

  String dateFromText = "";
  String dateToText = "";

  Future<Null> selectFormTimePicker(BuildContext context) async {
    isFormDate = true;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateForm,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != dateForm) {
      dateForm = picked;

      dateFromText =
          "${dateForm.day.toString()}-${dateForm.month.toString()}-${dateForm.year.toString()}";

      print(dateFromText);
    }
    emit(SelectFormTimePickerState());
  }

  Future<Null> selectToTimePicker(BuildContext context) async {
    isToDate = true;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTo,
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dateTo) {
      dateTo = picked;

      dateToText =
          "${dateTo.day.toString()}-${dateTo.month.toString()}-${dateTo.year.toString()}";

      print(dateToText);
    }
    emit(SelectToTimePickerState());
  }

  ////FetchData Here From Post Api and All Controller

  TextEditingController searchController = TextEditingController();
  bool isComeData = false;
  bool isComeDataWrong = false;

  //clear

  void clearAll() {
    isFormDate = false;
    isToDate = false;
    searchController.clear();
    isComeData = false;

    postSalesReport(
      dateFrom: "",
      nameSearch: "",
    );

    emit(ClearAllButtonState());
  }

  late SaleReportModel saleReportModel;

  Future postSalesReport({
    required String nameSearch,
    required String dateFrom,
  }) async {
    String? token = await this.userPreferences.getUserToken();
    emit(SearchLoadingState());
    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/orders/sales-report');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "tableColumns": [
              "order_number",
              "order_number",
              "client",
              "total",
              "amount_paid",
              "amount_remaining"
            ],
            "draw": 0,
            "length": 10,
            "column": 0,
            "dir": "desc",
            "created_at": dateFrom,
            "order_number": "",
            "name": nameSearch,
            "total": "",
            "amount_remaining": "",
            "amount_paid": "",
            "to": "",
            "from": ""
          }));
      if (response.statusCode == 200) {
        isComeData = true;

        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders'];

        saleReportModel = SaleReportModel.fromJson(data);
        // print("Walid : ${saleReportModel.data![0].client!.mobile}");

      } else {
        isComeData = false;
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    emit(FeatchDataSucessState());
  }

  // Infinite Scrolling Pagination code

  // final ScrollController scrollController = ScrollController();
  // List<String> items = [];
  // bool loading = false;
  // bool allLoaded = false;

  // mockFetch() async {
  //   if (allLoaded) {
  //     return;
  //   }

  //   loading = true;

  //   await Future.delayed(Duration(milliseconds: 500));
  //   List<String> newData = items.length >= 200
  //       ? []
  //       : List.generate(20, (index) => "List Walid ${index + items.length}");
  //   if (newData.isNotEmpty) {
  //     items.addAll(newData);
  //   }

  //   loading = false;
  //   allLoaded = newData.isEmpty;
  //   emit(pagintionLoadingState());
  // }

  // scrollcont() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels >=
  //             scrollController.position.maxScrollExtent &&
  //         !loading) {
  //       mockFetch();
  //     }
  //   });
  // }
}
