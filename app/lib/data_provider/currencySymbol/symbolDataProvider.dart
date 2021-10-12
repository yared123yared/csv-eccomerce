import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:app/models/symbolModel/symbolModel.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SymbolDataProvider {
  final UserPreferences userPreferences;

  SymbolDataProvider(this.userPreferences);

  Future<SymbolModel> getSymbol() async {
    bool connected = await ConnectionChecker.CheckInternetConnection();
    await APICacheManager().isAPICacheKeyExist("SymbolData");
    String? token = await this.userPreferences.getUserToken();
    late SymbolModel symbolModel;
    try {
      if (connected) {
        final url =
            Uri.parse("http://csv.jithvar.com/api/v1/currencies/company");
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "SymbolData",
            syncData: response.body,
          );
          await APICacheManager().addCacheData(cacheDBModel);
          var extractedData = json.decode(response.body);
          symbolModel = SymbolModel.fromJson(extractedData);
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("SymbolData");
        final extractedData =
            json.decode(cacheData.syncData) as Map<String, dynamic>;
        symbolModel = SymbolModel.fromJson(extractedData);
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    return symbolModel;
  }
}
