import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/OrdersDrawer/orderbyDebt_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;

class OrderByDebtDataProvider {
  final UserPreferences userPreferences;
  OrderByDebtDataProvider(this.userPreferences);

  Future<List<DataOrderByDebt>> getOrdersByDebt() async {
    String? token = await this.userPreferences.getUserToken();
    bool connected = await ConnectionChecker.CheckInternetConnection();
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("API_OrderByDebt");
    late List<DataOrderByDebt> orderByDebtdata = [];

    try {
      if (connected) {
        await APICacheManager().deleteCache("API_OrderByDebt");
        if (!isCacheExist) {
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
                "draw": 10,
                "length": 5,
                "search": "",
                "column": 0,
                "field": "",
                "relationship": false,
                "relationship_field": "",
                "dir": "desc"
              }));
          if (response.statusCode == 200) {
            APICacheDBModel cacheDBModel = new APICacheDBModel(
              key: "API_OrderByDebt",
              syncData: response.body,
            );
            await APICacheManager().addCacheData(cacheDBModel);
            final extractedData =
                json.decode(response.body) as Map<String, dynamic>;

            final data = extractedData['orders']['data'];

            return data
                .map((orderbydebts) =>
                    orderByDebtdata.add(DataOrderByDebt.fromJson(orderbydebts)))
                .toList();
          } else {
            throw Exception('Failed to load courses');
          }
        } else {
          var cacheData =
              await APICacheManager().getCacheData("API_OrderByDebt");
          final extractedData =
              json.decode(cacheData.syncData) as Map<String, dynamic>;

          final data = extractedData['orders']['data'];

          return data
              .map((orderbydebts) =>
                  orderByDebtdata.add(DataOrderByDebt.fromJson(orderbydebts)))
              .toList();
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("API_OrderByDebt");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

        return data
            .map((orderbydebts) =>
                orderByDebtdata.add(DataOrderByDebt.fromJson(orderbydebts)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }

    return orderByDebtdata;
  }

  Future<List<DataOrderByDebt>> getOrdersByDebtSearch(String searchName) async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataOrderByDebt> searchOrderByDebtdata = [];
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
            "field": "",
            "relationship": false,
            "relationship_field": "first_name",
            "dir": "desc"
          }));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

        return data
            .map((searchOrderbydebts) => searchOrderByDebtdata
                .add(DataOrderByDebt.fromJson(searchOrderbydebts)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return searchOrderByDebtdata;
  }
}
