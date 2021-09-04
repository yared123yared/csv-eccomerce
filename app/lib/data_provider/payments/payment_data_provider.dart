import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/payment/payment_container_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentDataProvider {
  final UserPreferences userPreferences;
  PaymentDataProvider(this.userPreferences);

  Future<List<DataPayment>> getPayMentConatiner() async {
    String? token = await this.userPreferences.getUserToken();
    bool connected = await ConnectionChecker.CheckInternetConnection();

    await APICacheManager().isAPICacheKeyExist("off_payment");
    late List<DataPayment> dataPayment = [];

    try {
      if (connected) {
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
              "length": 10000,
              "search": "",
              "column": 0,
              "dir": "asc"
            }));
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "off_payment",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;
          final data = extractedData['collections']['data'];
          return data
              .map((datapayment) =>
                  dataPayment.add(DataPayment.fromJson(datapayment)))
              .toList();
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("off_payment");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;
        final data = extractedData['collections']['data'];
        return data
            .map((datapayment) =>
                dataPayment.add(DataPayment.fromJson(datapayment)))
            .toList();
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return dataPayment;
  }

  //search payment

  Future<List<DataPayment>> getSearchPayMentConatiner(
      String searchAmount) async {
    String? token = await this.userPreferences.getUserToken();

    late List<DataPayment> searchDataPayment = [];

    try {
      final url =
          Uri.parse('http://csv.jithvar.com/api/v1/paginated-collections');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "draw": 0,
          "length": 10000,
          "search": searchAmount,
          "column": 0,
          "dir": "asc"
        }),
      );
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData['collections']['data'];
        return data
            .map((datapayment) =>
                searchDataPayment.add(DataPayment.fromJson(datapayment)))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return searchDataPayment;
  }
}
