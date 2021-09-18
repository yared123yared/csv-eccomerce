import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/dashboard/recent_order_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;

class RecentDataProvider {
  final UserPreferences userPreferences;

  RecentDataProvider(this.userPreferences);

  Future<List<RecentOrderData>> getRecentData() async {
    String? token = await this.userPreferences.getUserToken();
    late List<RecentOrderData> recentOrder = [];
    bool connected = await ConnectionChecker.CheckInternetConnection();
    await APICacheManager().isAPICacheKeyExist("RecentData");

    try {
      if (connected) {
        final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/all');

        final response = await http.post(url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "tableColumns": [
                "order_number",
                "client",
                "created_at",
                "total",
                "amount_remaining"
              ],
              "draw": 0,
              "length": 10000,
              "search": "",
              "column": 0,
              "field": "",
              "relationship": false,
              "relationship_field": "",
              "dir": "desc"
            }));
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "RecentData",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['orders']['data'];

          return data
              .map((recentorder) =>
                  recentOrder.add(RecentOrderData.fromJson(recentorder)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("RecentData");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;
        final data = extractedData['orders']['data'];

        return data
            .map((recentorder) =>
                recentOrder.add(RecentOrderData.fromJson(recentorder)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return recentOrder;
  }

  Future<List<RecentOrderData>> getSearchRecentData(String nameSearch) async {
    String? token = await this.userPreferences.getUserToken();
    late List<RecentOrderData> searchRecentOrder = [];

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/all');

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "tableColumns": [
              "order_number",
              "client",
              "created_at",
              "total",
              "amount_remaining"
            ],
            "draw": 0,
            "length": 10000,
            "search": nameSearch,
            "column": 0,
            "field": "client",
            "relationship": true,
            "relationship_field": "first_name",
            "dir": "desc"
          }));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

        return data
            .map((searchrecentorder) => searchRecentOrder
                .add(RecentOrderData.fromJson(searchrecentorder)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return searchRecentOrder;
  }
}
