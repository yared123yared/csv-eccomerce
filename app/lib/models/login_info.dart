import 'users.dart';

class LoginInfo {
  String? email;
  String? password;
  LoginInfo({email, password});
}

class LoggedUserInfo {
  String? token;
  User? user;

  LoggedUserInfo({this.token, this.user});
  // read from json
  LoggedUserInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
// write from json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
