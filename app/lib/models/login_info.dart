import 'users.dart';

class LoginInfo {
  late String email;
  late String password;
  LoginInfo(String email, password) {
    this.email = email;
    this.password = password;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }
}

class LoggedUserInfo {
  String? token;
  User? user;

  LoggedUserInfo({this.token, this.user});
  // read from json
  LoggedUserInfo.fromJson(Map<String, dynamic> json) {
    print("converting json");
    token = json['token'];
    print("---lf--2");
    user =  User.fromJson(json['user']);
    print("Completed the json converting token:${token} user:${user}");
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
