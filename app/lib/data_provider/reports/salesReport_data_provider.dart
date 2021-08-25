import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/repoets_model/sales_report_models.dart';

class SalesReportDataProvider {
  final UserPreferences userPreferences;

  

  SalesReportDataProvider(this.userPreferences);
  Future<List<DataSaleReport>> getSalesReport() async {
    String? token = await this.userPreferences.getUserToken();
    bool connected = await ConnectionChecker.CheckInternetConnection();
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("API_salesReports");
    late List<DataSaleReport> salesReportData = [];

    if (connected) {
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
              "created_at": "",
              "order_number": "",
              "name": "",
              "total": "",
              "amount_remaining": "",
              "amount_paid": "",
              "to": "",
              "from": ""
            }));
        if (response.statusCode == 200) {
          await APICacheManager().deleteCache("API_salesReports");
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_salesReports",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);

          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['orders']['data'];

          // print("Walid mahmhs msn ${total}");
          return data
              .map((salesReport) =>
                  salesReportData.add(DataSaleReport.fromJson(salesReport)))
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
              "created_at": "",
              "order_number": "",
              "name": "",
              "total": "",
              "amount_remaining": "",
              "amount_paid": "",
              "to": "",
              "from": ""
            }));

        print("Sales Report Url Hint");
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "API_salesReports",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);

          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;

          final data = extractedData['orders']['data'];

          // print("Walid mahmhs msn ${total}");
          return data
              .map((salesReport) =>
                  salesReportData.add(DataSaleReport.fromJson(salesReport)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData =
            await APICacheManager().getCacheData("API_salesReports");

        print("Sales Report Cache Hint");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

        // print("Walid mahmhs msn ${total}");
        return data
            .map((salesReport) =>
                salesReportData.add(DataSaleReport.fromJson(salesReport)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return salesReportData;
  }
}
