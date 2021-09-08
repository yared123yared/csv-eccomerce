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
    print("+++++++++++++++++++++++++This is the cart:${request!.cart![0].selectedAttributes}");
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

  Future<bool> updateOrder(Request req) async {
    String? token = await this.userPreferences.getUserToken();
    // late List<Data> products_return = [];
    print("---update order data provider");
    // print(jsonEncode(request).toString());
    print("req--id--${req.id}");
    try {
      // final url = Uri.parse('https://csv.jithvar.com/api/v1/orders/${req.id}');

      // req.transactionId = "123";
      // req.total = 2134;
      // req.amountPaid = 32;
      // req.amountRemaining = 10;
      // Map<String, dynamic> jsonData = request.toJson();
      print(jsonEncode(req));
      print("------------");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
        'PUT',
        Uri.parse(
          'https://csv.jithvar.com/api/v1/orders/${req.id}',
        ),
      );
      request.body = json.encode(req);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(await response.stream.bytesToString());
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print("Exception thrown $e");
    }
    return false;
  }

  Future<List<OrderToBeUpdated>> OrderData(String id) async {
    String? token = await this.userPreferences.getUserToken();
    List<OrderToBeUpdated> data = [];
    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/orders/${id}');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print("---fetch--order--detail---");
      print(
          "Http response ${response.statusCode} and response body ${response.body}");
      if (response.statusCode != 200) {
        print("---48");
        throw HttpException('200');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        // print(extractedData);
        if (extractedData['products'] != null) {
          extractedData['products'].forEach((v) {
            if (v != null) {
              if (v["product"] != null) {
                // print("data----");
                Data x = Data.fromJson(v["product"]);
                // print(jsonEncode(x).toString());
                x.quantity = v["quantity"];
                x.order = v["order"]["id"];
                int cartId = v["order"]["id"];
                int quantity = v["quantity"];
                double price = double.parse(v["price"]);
                double total = double.parse(v["total"]);

                OrderToBeUpdated cartX = new OrderToBeUpdated(
                  cartId: cartId,
                  data: x,
                  quantity: quantity,
                  total: total,
                  price: price,
                );
                data.add(cartX);
              }
            }
          });
        }
        // print("----ordered product items---");
        // print(json.encode(data).toString);
        // print(data.length);
        return data;
      }
    } catch (e) {
      print("Exception fetching order detail");
      print(e);
    }
    return data;
  }
}
