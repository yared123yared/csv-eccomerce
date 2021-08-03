import 'dart:convert';
import 'dart:io';
import 'package:app/models/product/product.dart';
import 'package:flutter/cupertino.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ProductDataProvider {
  final _baseUrl = 'http://csv.jithvar.com/api/v1';
  final http.Client httpClient;
  final token = '414|oAIZLndxR089Gqw4118DGZFpIQWrvrFmBNZqCsWG';

  ProductDataProvider({required this.httpClient}) : assert(httpClient != null);

  Future<Products> getProducts(int page) async {
    late Products products_return;
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
      // print("Http response ${response.statusCode}");
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        // print(extractedData);
        // final products = json.decode(response.body) as Map<String, dynamic>;
        products_return = Products.fromJson(extractedData['products']);
        print(response.body);
        print("product current page ${products_return.currentPage}");
        return products_return;
      } else {
        print(response.body);
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return products_return;
  }
}
