import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/repoets_model/custom_report_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;

class CustomDebtDataProvider {
  final UserPreferences userPreferences;

  CustomDebtDataProvider(this.userPreferences);
  Future<List<DataCustomReport>> getCustomReport() async {
    String? token = await this.userPreferences.getUserToken();
    bool connected = await ConnectionChecker.CheckInternetConnection();
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("API_CustomDebt");
    late List<DataCustomReport> customDebt = [];

    if (connected) {
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
          await APICacheManager().deleteCache("API_CustomDebt");
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_CustomDebt",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['clients']['data'];
          return data
              .map((customdebt) =>
                  customDebt.add(DataCustomReport.fromJson(customdebt)))
              .toList();

          //print("Walid : ${customReportModel.data![0].email}");
        } else {
          throw Exception('Failed to load courses');
        }
      } catch (e) {
        print("Exception throuwn $e");
      }
    }
    try {
      if (!isCacheExist) {
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
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_CustomDebt",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['clients']['data'];
          return data
              .map((customdebt) =>
                  customDebt.add(DataCustomReport.fromJson(customdebt)))
              .toList();

          //print("Walid : ${customReportModel.data![0].email}");
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("API_CustomDebt");

        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['clients']['data'];
        return data
            .map((customdebt) =>
                customDebt.add(DataCustomReport.fromJson(customdebt)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }

    return customDebt;
  }
}
