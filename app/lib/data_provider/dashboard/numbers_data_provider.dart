import 'dart:convert';

import 'package:app/models/dashboard/number_dashBoard_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class NumbersDataProvider {
  final UserPreferences userPreferences;

  NumbersDataProvider(this.userPreferences);

  Future<NumbersDashBoardModel> getNumberDashBord() async {
    String? token = await this.userPreferences.getUserToken();
    late NumbersDashBoardModel numbersDashBoard;
    try {
      final url = Uri.parse("http://csv.jithvar.com/api/v1/dashboard");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

    

        numbersDashBoard = NumbersDashBoardModel.fromJson(extractedData);
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return numbersDashBoard;
  }
}
