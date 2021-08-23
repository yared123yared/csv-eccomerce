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

  Future<LoggedUserInfo?> offlineLogin(LoginInfo loginInfo) async {
    LoggedUserInfo? loggedUserInfo;
    try {
      String? email = await this.userPreferences.getUserEmail();
      String? password = await this.userPreferences.getUserPassword();
      if (email == null || password == null) {
        throw HttpException("unable to read credential");
      }
      if (email == loginInfo.email && password == loginInfo.password) {
        loggedUserInfo = await this.userPreferences.getUserInformation();
        if (loggedUserInfo == null) {
          throw HttpException("unable to read credential");
        }
        return loggedUserInfo;
      } else {
        throw HttpException("incorrect username or password");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<LoggedUserInfo> login(LoginInfo loginInfo) async {
    LoggedUserInfo loggedUserInfo;
    final urlLogin = Uri.parse('${baseUrl}/login');
    try {
      final response = await http.post(
        urlLogin,
        body: loginInfo.toJson(),
      );
      if (response.statusCode != 201) {
        print("Faileddddd");
        throw HttpException('Incorrect email or password');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        print("success, ${extractedData}");
        loggedUserInfo = LoggedUserInfo.fromJson(extractedData);
        print("----55");
        await this.userPreferences.storeUserInformation(loggedUserInfo);
        print("----56");
        String expiry = response.headers['Expires'].toString();
        print("----57");
        await this
            .userPreferences
            .storeTokenAndExpiration(loggedUserInfo.token!, expiry);
        print("----58");
        await this.userPreferences.storeEmail(loginInfo.email);
        print("----59");
        await this.userPreferences.storePassword(loginInfo.password);
        print('--------------login');
        print(loggedUserInfo.token);
        print('--------------login');
      }
    } catch (e) {
      print("login--failed");
      print(e);
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

  Future<void> sendOtp(String email) async {
    final urlLogin = Uri.parse('${baseUrl}/forgot-password');
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;

    try {
      final response = await http.post(
        urlLogin,
        body: data,
      );
      if (response.statusCode != 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> changePassword(
      String email, otp, password, confirmed_password) async {
    final urlLogin = Uri.parse('${baseUrl}/change-password-otp');
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['otp'] = otp;
    data['password'] = password;
    data['password_confirmation'] = confirmed_password;

    try {
      final response = await http.post(
        urlLogin,
        body: data,
      );
      if (response.statusCode != 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        throw HttpException(extractedData['message']);
      }
    } catch (e) {
      throw (e);
    }
  }
}
