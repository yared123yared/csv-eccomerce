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

  Future<Products> getProducts() async {
    Products products_return = new Products();
    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/paginated-products?page=1');
      print(url);
      final response = await http.post(
        url,
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Content-Length": '<calculated when request is sent>',
          "Host": '<calculated when request is sent>',
          'Authorization': 'Bearer $token',
        },
      );
      print("Http response ${response.statusCode}");
      if (response.statusCode == 200) {
        final products = jsonDecode(response.body) as Map<String, dynamic>;
        products_return = Products.fromJson(products);

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
