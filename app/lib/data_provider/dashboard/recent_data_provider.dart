import 'dart:convert';

import 'package:app/models/dashboard/recent_order_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class RecentDataProvider {
  final UserPreferences userPreferences;

  RecentDataProvider(this.userPreferences);

  Future<List<RecentOrderData>> getRecentData() async {
    String? token = await this.userPreferences.getUserToken();
    late List<RecentOrderData> recentOrder = [];
    print(recentOrder.length);

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
            "length": 100,
            "search": "",
            "column": 0,
            "field": "",
            "relationship": false,
            "relationship_field": "",
            "dir": "desc"
          }));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['orders']['data'];

       // print(recentOrder.length);

        return data
            .map((recentorder) =>
                recentOrder.add(RecentOrderData.fromJson(recentorder)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return recentOrder;
  }
}
