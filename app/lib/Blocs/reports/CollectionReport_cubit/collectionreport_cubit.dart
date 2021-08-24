import 'dart:convert';

import 'package:app/Blocs/reports/CollectionReport_cubit/collectionreport_state.dart';
import 'package:app/models/repoets_model/collection_report_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CollectionReportCubit extends Cubit<CollectionReportState> {
  final UserPreferences userPreferences;
  CollectionReportCubit(this.userPreferences)
      : super(CollectionReportInitialState());

  static CollectionReportCubit get(BuildContext context) =>
      BlocProvider.of(context);

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
    emit(SelectFormTimePickerCollState());
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
    emit(SelectToTimePickerCollState());
  }

  //clear

  void clearAll() {
    isFormDate = false;
    isToDate = false;
    searchController.clear();
    isComeData = false;

    postCollectionReport(
      nameSearch: "",
      dateFrom: "",
      dateTo: "",
    );

    emit(ClearAllCollButtonState());
  }

  ////FetchData Here From Post Api and All Controller

  TextEditingController searchController = TextEditingController();
  bool isComeData = false;
  bool isComeDataWrong = false;

  late CollectionReportModel collectionReportModel;

  Future postCollectionReport({
    required String nameSearch,
    required String dateTo,
    required String dateFrom,
  }) async {
    String? token = await this.userPreferences.getUserToken();
    emit(SearchLoadingCollState());
    try {
      final url = Uri.parse(
          'http://csv.jithvar.com/api/v1/payments/reports/collection');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "tableColumns": [
              "created_at",
              "payment_method",
              "id",
              "client",
              "amount_remaining",
              "status",
              "reason_denied",
              "actions"
            ],
            "draw": 0,
            "length": 10,
            "column": 0,
            "dir": "desc",
            "created_at": "",
            "name": nameSearch,
            "amount_paid": "",
            "to": dateTo,
            "from": dateFrom,
            "orderNumber": "",
            "payment_method": "",
            "status": ""
          }));
      if (response.statusCode == 200) {
        isComeData = true;

        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['collections'];

        collectionReportModel = CollectionReportModel.fromJson(data);
        print("Walid : ${collectionReportModel.data![0].order!.addressId}");
      } else {
        isComeData = false;
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    emit(FeatchDataSucessCollState());
  }
}
