import 'dart:convert';
import 'dart:io';

import 'package:app/preferences/user_preference_data.dart';

import '../models/login_info.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client httpClient;
  final UserPreferences userPreferences;

  UserDataProvider({required this.httpClient, required this.userPreferences});

  final String baseUrl = 'http://csv.jithvar.com/api/v1';

  Future<LoggedUserInfo> login(LoginInfo loginInfo) async {
    LoggedUserInfo loggedUserInfo;
    final urlLogin = Uri(host: '$baseUrl/login');

    try {
      final response = await http.post(
        urlLogin,
        body: json.encode({
          'email': loginInfo.email,
          'password': loginInfo.password,
        }),
      );

      if (response.statusCode != 201) {
        throw HttpException('Incorrect email or password');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        loggedUserInfo = LoggedUserInfo.fromJson(extractedData);
        await this.userPreferences.storeUserInformation(loggedUserInfo);
        String expiry = response.headers['Expires'].toString();
        await this.userPreferences.storeTokenAndExpiration(loggedUserInfo.token!,expiry);
      }
    } catch (e) {
      throw e;
    }
    return loggedUserInfo;
  }
}
