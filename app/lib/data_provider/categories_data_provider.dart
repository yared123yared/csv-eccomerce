import 'dart:convert';
import 'dart:io';
import 'package:app/models/category/categories.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/product/product.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class CategoriesDataProvider {
  final _baseUrl = 'http://csv.jithvar.com/api/v1';
  final http.Client httpClient;
  final UserPreferences userPreferences;

  CategoriesDataProvider(
      {required this.httpClient, required this.userPreferences})
      : assert(httpClient != null);

  Future<List<Categories>> getCategories() async {
    String? token = await this.userPreferences.getUserToken();
    print("Token: ${token}");
    late List<Categories> categories_return = [];
    try {
      final url = Uri.parse('https://csv.jithvar.com/api/v1/categories');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print('Arrived here ${response.body}');
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['categories'];

        return (data
            .map((category) => Categories.fromJson(category))
            .toList()
            .cast<Categories>());
      } 
      
      else {
        // print(response.body);
        throw Exception('Failed to load courses');
        
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return categories_return;
  }
}
