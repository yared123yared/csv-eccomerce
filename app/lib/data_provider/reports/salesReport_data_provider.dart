import 'dart:convert';

import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;
import 'package:app/models/repoets_model/sales_report_models.dart';

class SalesReportDataProvider {
  final UserPreferences userPreferences;

  SalesReportDataProvider(this.userPreferences);
  Future<List<DataSaleReport>> getSalesReport() async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataSaleReport> salesReportData = [];
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
    return salesReportData;
  }
}
