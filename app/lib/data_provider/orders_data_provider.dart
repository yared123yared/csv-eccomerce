import 'dart:convert';
import 'dart:io';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/models/request/request.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class OrderDataProvider {
  final _baseUrl = 'http://csv.jithvar.com/api/v1/orders';
  final http.Client httpClient;
  final UserPreferences userPreferences;

  OrderDataProvider({required this.httpClient, required this.userPreferences})
      : assert(httpClient != null);

  Future<bool> createOrder(Request? request) async {
    String? token = await this.userPreferences.getUserToken();
    // late List<Data> products_return = [];
    print("This is the caategory Id");
    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders');

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "total": 1798,
            "payment_when": "now",
            "payment_method": "wallet",
            "type_of_wallet": "smilepay",
            "transaction_id": "tassdsf",
            "amount_paid": 41,
            "amount_remaining": 1757,
            "address_id": 220,
            "client_id": 158,
            "cart": [
              {
                "id": 2,
                "amountInCart": 1,
                "selectedAttributes": [6, 11]
              },
              {
                "id": 9,
                "amountInCart": 1,
                "selectedAttributes": [35]
              }
            ]
          }));

      print(
          "Http response ${response.statusCode} and response body ${response.body}");
      if (response.statusCode == 201) {
        return true;
      } else {
        // print(response.body);
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return false;
  }
}
