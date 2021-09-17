import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/dashboard/number_dashBoard_model.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;

class NumbersDataProvider {
  final UserPreferences userPreferences;

  NumbersDataProvider(this.userPreferences);

  Future<NumbersDashBoardModel> getNumberDashBord() async {
    bool connected = await ConnectionChecker.CheckInternetConnection();
    await APICacheManager().isAPICacheKeyExist("NumberDashBoard");
    String? token = await this.userPreferences.getUserToken();
    late NumbersDashBoardModel numbersDashBoard;
    try {
      if (connected) {
        final url = Uri.parse("http://csv.jithvar.com/api/v1/dashboard");
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "NumberDashBoard",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          var extractedData = json.decode(response.body);

          numbersDashBoard = NumbersDashBoardModel.fromJson(extractedData);
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("NumberDashBoard");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;
        numbersDashBoard = NumbersDashBoardModel.fromJson(extractedData);
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return numbersDashBoard;
  }
}
