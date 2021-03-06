import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/repoets_model/collection_report_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;

class CollectionDataProvider {
  final UserPreferences userPreferences;
  CollectionDataProvider(this.userPreferences);
  Future<List<DataCollection>> getCollectionReport() async {
    String? token = await this.userPreferences.getUserToken();
    bool connected = await ConnectionChecker.CheckInternetConnection();

    await APICacheManager().isAPICacheKeyExist("off_CollectionReport");
    late List<DataCollection> datatCollection = [];

    try {
      if (connected) {
        final url = Uri.parse(
            'http://csv.jithvar.com/api/v1/payments/reports/collection');
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
              "payment_method",
              "id",
              "client",
              "amount_remaining",
              "status",
              "reason_denied",
              "actions"
            ],
            "draw": 0,
            "length": 10000,
            "column": 0,
            "dir": "desc",
            "created_at": "",
            "name": "",
            "amount_paid": "",
            "to": "",
            "from": "",
            "orderNumber": "",
            "payment_method": "",
            "status": ""
          }),
        );
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "off_CollectionReport",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['collections']['data'];

          return data
              .map((salesReport) =>
                  datatCollection.add(DataCollection.fromJson(salesReport)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData =
            await APICacheManager().getCacheData("off_CollectionReport");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['collections']['data'];

        return data
            .map((salesReport) =>
                datatCollection.add(DataCollection.fromJson(salesReport)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return datatCollection;
  }

//////////////Search name

  Future<List<DataCollection>> getSearchCollectionReport(
      String nameSearch) async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataCollection> searchCollection = [];

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
            "length": 10000,
            "column": 0,
            "dir": "desc",
            "created_at": "",
            "name": nameSearch,
            "amount_paid": "",
            "to": "",
            "from": "",
            "orderNumber": "",
            "payment_method": "",
            "status": ""
          }));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['collections']['data'];

        return data
            .map((salesReport) =>
                searchCollection.add(DataCollection.fromJson(salesReport)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return searchCollection;
  }

  ///fro, to search

  Future<List<DataCollection>> getFromToCollectionReport({
    required String dateTo,
    required String dateFrom,
  }) async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataCollection> fromToCollection = [];

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
            "length": 10000,
            "column": 0,
            "dir": "desc",
            "created_at": "",
            "name": "",
            "amount_paid": "",
            "to": dateTo,
            "from": dateFrom,
            "orderNumber": "",
            "payment_method": "",
            "status": ""
          }));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['collections']['data'];

        return data
            .map((salesReport) =>
                fromToCollection.add(DataCollection.fromJson(salesReport)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return fromToCollection;
  }
}
