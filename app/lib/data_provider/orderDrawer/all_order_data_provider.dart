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

    try {
      if (connected) {
        await APICacheManager().deleteCache("API_AllOrders");

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
                "length": 100,
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
              .map((salesReport) =>
                  allOrdersData.add(DataAllOrders.fromJson(salesReport)))
              .toList();
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("API_AllOrders");

        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

        return data
            .map((salesReport) =>
                allOrdersData.add(DataAllOrders.fromJson(salesReport)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }

    return allOrdersData;
  }

  ///////////Search Code

  Future<List<DataAllOrders>> getSearchAllOrders(String searchName) async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataAllOrders> searchallOrdersData = [];

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/all');
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
            "order_number",
            "client",
            "total",
            "amount_paid",
            "amount_remaining",
            "actions"
          ],
          "draw": 0,
          "length": 100,
          "search": searchName,
          "column": 0,
          "field": "client",
          "relationship": true,
          "relationship_field": "first_name",
          "dir": "desc"
        }),
      );

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

        return data
            .map((searchallorders) => searchallOrdersData
                .add(DataAllOrders.fromJson(searchallorders)))
            .toList();

        // print("Walid roaa doaa : ${allOrdersModel.data!.length}");
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return searchallOrdersData;
  }
}
