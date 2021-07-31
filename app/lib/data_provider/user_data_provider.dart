import 'dart:convert';
import 'dart:io';

import '../models/login_info.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  late final http.Client httpClient;

  UserDataProvider({required this.httpClient});

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
      }  else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        loggedUserInfo = LoggedUserInfo.fromJson(extractedData);

      }
    } catch (e) {
      throw e;
    }
    return loggedUserInfo;
  }
}
