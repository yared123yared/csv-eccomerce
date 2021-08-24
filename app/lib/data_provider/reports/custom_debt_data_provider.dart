import 'dart:convert';

import 'package:app/models/repoets_model/custom_report_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class CustomDebtDataProvider {
  final UserPreferences userPreferences;

  CustomDebtDataProvider(this.userPreferences);
  Future<List<DataCustomReport>> getCustomReport() async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataCustomReport> customDebt = [];

    try {
      final url = Uri.parse('http://csv.jithvar.com/api/v1/clients/debts');
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
            "field": "",
            "relationship": false,
            "relationship_field": "",
            "dir": "asc"
          }));
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['clients']['data'];
        return data
            .map((customdebt) =>
                customDebt.add(DataCustomReport.fromJson(customdebt)))
            .toList();

        //print("Walid : ${customReportModel.data![0].email}");
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return customDebt;
  }
}
