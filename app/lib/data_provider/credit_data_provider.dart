import 'dart:convert';
import 'dart:io';

import 'package:app/models/users.dart';
import 'package:app/preferences/user_preference_data.dart';

import '../models/login_info.dart';
import 'package:http/http.dart' as http;

class CreditDataProvider {
  final http.Client httpClient;
  final UserPreferences userPreferences;

  CreditDataProvider({required this.httpClient, required this.userPreferences});

  final String baseUrl = 'http://csv.jithvar.com/api/v1';

  Future<User> UpdateUserInformation(int user_id) async {
    String? token = await this.userPreferences.getUserToken();
    User userInfo;
    final urlLogin =
        Uri.parse('https://csv.jithvar.com/api/v1/users/${user_id}');
    try {
      final response = await http.get(
        urlLogin,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        print("Faileddddd");
        print(extractedData["message"]);
        throw HttpException('Incorrect email or password');
      } else {
        extractedData = json.decode(response.body) as Map<String, dynamic>;
        print("success, ${extractedData}");
        userInfo = User.fromJson(extractedData);
        print("----55");
        // get already stored value from the local db
        LoggedUserInfo loggeduserInfo =
            await this.userPreferences.getUserInformation() as LoggedUserInfo;
        loggeduserInfo.user = userInfo;

        await this.userPreferences.storeUserInformation(loggeduserInfo);

        print("----56");
        String expiry = response.headers['Expires'].toString();
        print("----57");

        print("----58");
        // await this.userPreferences.storeEmail(loginInfo.email);
        print("----59");
        // await this.userPreferences.storePassword(loginInfo.password);

      }
    } catch (e) {
      print("login--failed");
      print(e);
      throw e;
    }
    return userInfo;
  }
}
