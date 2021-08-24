import 'package:app/models/payment/payment_container_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentDataProvider {
  final UserPreferences userPreferences;
  PaymentDataProvider(this.userPreferences);

  Future<List<DataPayment>> getPayMentConatiner() async {
    String? token = await this.userPreferences.getUserToken();
    late List<DataPayment> dataPayment = [];
    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/paginated-collections');
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
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['collections']['data'];
        return data
            .map((datapayment) =>
                dataPayment.add(DataPayment.fromJson(datapayment)))
            .toList();

        //print("walid payment  ${payMentContainerModel.data![0].date}");
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return dataPayment;
  }
}
