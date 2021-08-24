import 'package:app/models/photo.dart';

import 'role.dart';
import 'company.dart';

class User {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? phone;
  Role? role;
  Company? company;
  Photo? photo;
  String? locale;
  String? emailVerifiedAt;
  int? active;
  int? forcePwChange;

  User(
      {this.id,
      this.title,
      this.firstName,
      this.lastName,
      this.email,
      this.username,
      this.phone,
      this.role,
      this.company,
      this.photo,
      this.locale,
      this.emailVerifiedAt,
      this.active,
      this.forcePwChange});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    print("Arrived here");
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    print("Arrived here");
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    photo = json['photo'] != null ? new Photo.fromJson(json['company']) : null;
    print("Arrived here");
    // photo = json['photo'];
    locale = json['locale'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    forcePwChange = json['force_pw_change'];
    print("Finish mapping");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['phone'] = this.phone;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['photo'] = this.photo;
    data['locale'] = this.locale;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['force_pw_change'] = this.forcePwChange;
    return data;
  }
}
