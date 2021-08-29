import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;

class AllOrderDataProvider {
  final UserPreferences userPreferences;

  AllOrderDataProvider(this.userPreferences);

  Future<List<DataAllOrders>> getAllOrders() async {
    String? token = await this.userPreferences.getUserToken();
    bool connected = await ConnectionChecker.CheckInternetConnection();
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("API_AllOrders");
    late List<DataAllOrders> allOrdersData = [];

    if (connected) {
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
              "search": "",
              "column": 0,
              "field": "",
              "relationship": false,
              "relationship_field": "",
              "dir": "desc"
            }));
           
        if (response.statusCode == 200) {
          await APICacheManager().deleteCache("API_AllOrders");
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_AllOrders",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['orders']['data'];
          return data
              .map((allorders) =>
                  allOrdersData.add(DataAllOrders.fromJson(allorders)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } catch (e) {
        print("Exception throuwn $e");
      }
    }

    try {
      if (!isCacheExist) {
        final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/all');
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
                "amount_paid",
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
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_AllOrders",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['orders']['data'];
          return data
              .map((allorders) =>
                  allOrdersData.add(DataAllOrders.fromJson(allorders)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("API_AllOrders");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];
        return data
            .map((allorders) =>
                allOrdersData.add(DataAllOrders.fromJson(allorders)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return allOrdersData;
  }
}
