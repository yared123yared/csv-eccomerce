import 'dart:convert';
import 'package:app/models/dashboard/monthly_chart_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class MOnthlyChartDataProvider {
  final UserPreferences userPreferences;

  MOnthlyChartDataProvider(this.userPreferences);
  Future<List<MonthlyChartModel>> getMonthlyChart(String dateFrom) async {
    String? token = await this.userPreferences.getUserToken();
    late List<MonthlyChartModel> monthlyChart = [];
    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/charts/collections/monthly');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"from": "$dateFrom", "to": ""}),
      );

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['monthlyCollections'];

        return data
            .map((monthlyData) =>
                monthlyChart.add(MonthlyChartModel.fromJson(monthlyData)))
            .toList();
      }
    } catch (e) {
      print(e.toString());
    }

    return monthlyChart;
  }

 
}
