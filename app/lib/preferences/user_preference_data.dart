import 'dart:convert';

import '../models/login_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<void> storeUserInformation(LoggedUserInfo info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', jsonEncode(info));
  }

  Future<LoggedUserInfo?> getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? u_info = prefs.getString('user_info');
    Map<String, dynamic> json = jsonDecode(u_info!) as Map<String, dynamic>;
    var user = LoggedUserInfo.fromJson(json);
    return user;
  }

  Future<void> storeTokenAndExpiration(String token, String expiry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      print('storing token 1');
    print(token);
    await prefs.setString('token', token);
    await prefs.setString('expiry', expiry);
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('storing token 2');
    print(token);
    await prefs.setString('token', token);
  }

  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
   Future<void> storePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }
  Future<String?> getUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }
   Future<void> storeEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getExpiryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  DateTime getDateTimeFromString(String dateString) {
    return DateTime.parse(dateString);
  }

  bool isExpired(String expiry) {
    var date = DateTime.parse(expiry);
    if (date.isAfter(DateTime.now())) return false;
    return true;
  }
}
