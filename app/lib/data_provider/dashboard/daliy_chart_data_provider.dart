import 'dart:convert';

import 'package:app/models/dashboard/daliy_chart_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class DailyChartDataProvider {
  final UserPreferences userPreferences;

  DailyChartDataProvider(this.userPreferences);

  Future<List<DailyChartModel>> getDailyChart(String dateFrom) async {
    String? token = await this.userPreferences.getUserToken();
    late List<DailyChartModel> daliyChart = [];
    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/charts/collections/daily');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"from": dateFrom, "to": ""}),
      );

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['dailyCollections'];

        // print("Daily Chart $data");
        // print(daliyChart);
        return data
            .map((dailychart) =>
                daliyChart.add(DailyChartModel.fromJson(dailychart)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return daliyChart;
  }

  Future<List<DailyChartModel>> getDateFromToChart(
      String dateForm, String dateTo) async {
    String? token = await this.userPreferences.getUserToken();
    late List<DailyChartModel> dateFromToChart = [];
    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/charts/collections/daily');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"from": "1-7-2021", "to": "30-9-2021"}),
      );

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['dailyCollections'];

        // print("Daily Chart $data");
        // print(daliyChart);
        return data
            .map((dailychart) =>
                dateFromToChart.add(DailyChartModel.fromJson(dailychart)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return dateFromToChart;
  }
}
