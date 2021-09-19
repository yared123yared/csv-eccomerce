import 'dart:convert';

import 'package:app/models/OrdersDrawer/order_detailsModel.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class OrderDetailsDataProvider {
  final UserPreferences userPreferences;

  OrderDetailsDataProvider(this.userPreferences);

  Future<OrderDetailsAllModel> getAllOrderDetails(int id) async {
    String? token = await this.userPreferences.getUserToken();
    late OrderDetailsAllModel orderDetailsAllData;

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/${id}}');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        orderDetailsAllData = OrderDetailsAllModel.fromJson(extractedData);
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return orderDetailsAllData;
  }
}
