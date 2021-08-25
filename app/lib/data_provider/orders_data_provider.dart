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
            "total": request!.total,
            "payment_when": request.paymentWhen,
            "payment_method": request.paymentMethod,
            "type_of_wallet": request.typeOfWallet,
            "transaction_id": request.transactionId,
            "amount_paid": request.amountPaid,
            "amount_remaining": request.amountRemaining,
            "address_id": 324,
            "client_id": request.clientId,
            "cart": request.cart
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
