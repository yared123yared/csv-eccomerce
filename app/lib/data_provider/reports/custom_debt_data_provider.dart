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
    late List<DataCustomReport> customDebt = [];

    await APICacheManager().isAPICacheKeyExist("API_CustomDebtss");
    bool connected = await ConnectionChecker.CheckInternetConnection();

    try {
      if (connected) {
        final url = Uri.parse('http://csv.jithvar.com/api/v1/clients/debts');
        final response = await http.post(url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "draw": 0,
              "length": 10000,
              "search": "",
              "column": 0,
              "field": "",
              "relationship": false,
              "relationship_field": "",
              "dir": "asc"
            }));
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_CustomDebtss",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['clients']['data'];

          return data
              .map((searchcustomdebt) =>
                  customDebt.add(DataCustomReport.fromJson(searchcustomdebt)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData =
            await APICacheManager().getCacheData("API_CustomDebtss");
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

  Future<List<DataCustomReport>> getCustomReportSearch(
      String searchName) async {
    String? token = await this.userPreferences.getUserToken();
    await APICacheManager().isAPICacheKeyExist("Search_CustomDebtss");
    bool connected = await ConnectionChecker.CheckInternetConnection();
    late List<DataCustomReport> searchCustomDebt = [];

    try {
      if (connected) {
        final url = Uri.parse('http://csv.jithvar.com/api/v1/clients/debts');
        final response = await http.post(url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "draw": 0,
              "length": 10000,
              "search": searchName,
              "column": 0,
              "field": "first_name",
              "relationship": false,
              "relationship_field": "",
              "dir": "asc"
            }));
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "Search_CustomDebtss",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['clients']['data'];

          return data
              .map((searchcustomdebt) => searchCustomDebt
                  .add(DataCustomReport.fromJson(searchcustomdebt)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData =
            await APICacheManager().getCacheData("Search_CustomDebtss");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['clients']['data'];

        return data
            .map((searchcustomdebt) => searchCustomDebt
                .add(DataCustomReport.fromJson(searchcustomdebt)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return searchCustomDebt;
  }
}
