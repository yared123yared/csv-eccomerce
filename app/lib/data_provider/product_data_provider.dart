import 'dart:convert';
import 'dart:io';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:flutter/cupertino.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ProductDataProvider {
  final _baseUrl = 'http://csv.jithvar.com/api/v1';
  final http.Client httpClient;
  final token = '501|x2IWmxxwn9mmBX2ADFV4LzK8CxkP6jB3QyjHY6qB';

  ProductDataProvider({required this.httpClient}) : assert(httpClient != null);

  Future<List<Data>> getProducts(int page) async {
    late List<Data> products_return = [];
    try {
      final url = Uri.parse(
          'http://csv.jithvar.com/api/v1/paginated-products?page=$page');

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "draw": 0,
            "length": 10,
            "search": "",
            "column": 0,
            "dir": "asc"
          }));
      // print(
      //     "Http response ${response.statusCode} and response body ${response.body}");
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        // print("Extracted value $extractedData");
        // print("This is the data value ${extractedData['products']['data']}");
        final data = extractedData['products']['data'];
        // print("Data:${data}");

        return data
            .map((product) => Data.fromJson(product))
            .toList()
            .cast<Data>();
        // print(products_return.map((e) => e));
        // print("product current page ${products_return.currentPage}");
        // print(products_return);
        // return products_return;
      } else {
        // print(response.body);
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return products_return;
  }
}
