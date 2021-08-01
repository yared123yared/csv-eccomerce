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
    print('-----f');
    LoggedUserInfo loggedUserInfo;
    final urlLogin = Uri.parse('${baseUrl}/login');
    print('-----e');
    try {
      print(loginInfo.toJson());
      final response = await http.post(
        urlLogin,
        body: loginInfo.toJson(),
      );
      print(loginInfo.email);
      print(loginInfo.password);
      print('-a--------');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != 201) {
        print('-b--------');
        throw HttpException('Incorrect email or password');
      } else {
        print('-c--------');
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
      print('-d--------');
      print(e);
      throw e;
    }
    return loggedUserInfo;
  }
}
