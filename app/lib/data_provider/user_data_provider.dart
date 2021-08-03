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
    final urlLogin = Uri.parse('${baseUrl}/login');
    try {
      final response = await http.post(
        urlLogin,
        body: loginInfo.toJson(),
      );
      if (response.statusCode != 201) {
        throw HttpException('Incorrect email or password');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        loggedUserInfo = LoggedUserInfo.fromJson(extractedData);
        await this.userPreferences.storeUserInformation(loggedUserInfo);
        String expiry = response.headers['Expires'].toString();
        await this
            .userPreferences
            .storeTokenAndExpiration(loggedUserInfo.token!, expiry);
      }
    } catch (e) {
      throw e;
    }
    return loggedUserInfo;
  }

  Future<void> updatePassword(String password, confirmedPassword) async {
    final urlUpdatePassword = Uri.parse('${baseUrl}/change-password');

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = password;
    data['password_confirmation'] = confirmedPassword;
    try {
      String? token = await this.userPreferences.getUserToken();
      final response = await http.post(
        urlUpdatePassword,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      if (response.statusCode != 201) {
        throw HttpException('Error Occured');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        await this.userPreferences.storeToken(extractedData['token'].token!);
      }
    } catch (e) {
      throw e;
    }
  }
}
