import 'dart:convert';

import 'package:app/models/repoets_model/collection_report_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;

class CollectionDataProvider {
  final UserPreferences userPreferences;
  CollectionDataProvider(this.userPreferences);
  Future<List<DataCollection>> getCollectionReport() async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataCollection> datatCollection = [];

    try {
      final url = Uri.parse(
          'http://csv.jithvar.com/api/v1/payments/reports/collection');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "tableColumns": [
            "created_at",
            "payment_method",
            "id",
            "client",
            "amount_remaining",
            "status",
            "reason_denied",
            "actions"
          ],
          "draw": 0,
          "length": 10,
          "column": 0,
          "dir": "desc",
          "created_at": "",
          "name": "",
          "amount_paid": "",
          "to": "",
          "from": "",
          "orderNumber": "",
          "payment_method": "",
          "status": ""
        }),
      );
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final data = extractedData['collections']['data'];

        print(data);
        return data
            .map((salesReport) =>
                datatCollection.add(DataCollection.fromJson(salesReport)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return datatCollection;
  }
}
