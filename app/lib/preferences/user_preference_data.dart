import 'dart:convert';

import '../models/login_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
    // print('storing token 1');
    // print(token);
    await prefs.setString('token', token);
    await prefs.setString('expiry', expiry);
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('storing token 2');
    // print(token);
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
    return prefs.getString('expiry');
  }

  DateTime getDateTimeFromString(String dateString) {
    return DateTime.parse(dateString);
  }

  bool isExpired(String expiry) {
    var f = DateFormat("E, d MMM yyyy HH:mm:ss 'GMT'");

    // var date = f.format(DateTime.now().toUtc()) + " GMT";
    // print(date);
    var date = f.parse(expiry);
    print("check expiry time");
    print(date);
    if (date.isAfter(DateTime.now())) return false;
    return true;
  }
}
