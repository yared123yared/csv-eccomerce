class User {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? phone;
  Role? role;
  String? credit;
  String? creditLimitStartDate;
  String? creditLimitEndDate;
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
      this.credit,
      this.creditLimitStartDate,
      this.creditLimitEndDate,
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
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    credit = json['credit'];
    creditLimitStartDate = json['credit_limit_start_date'];
    creditLimitEndDate = json['credit_limit_end_date'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    locale = json['locale'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    forcePwChange = json['force_pw_change'];
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
    data['credit'] = this.credit;
    data['credit_limit_start_date'] = this.creditLimitStartDate;
    data['credit_limit_end_date'] = this.creditLimitEndDate;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    data['locale'] = this.locale;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['force_pw_change'] = this.forcePwChange;
    return data;
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? industry;
  String? mobile;
  String? fax;
  String? email;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  int? status;

  Company(
      {this.id,
      this.name,
      this.industry,
      this.mobile,
      this.fax,
      this.email,
      this.address,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.zipCode,
      this.status});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    industry = json['industry'];
    mobile = json['mobile'];
    fax = json['fax'];
    email = json['email'];
    address = json['address'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zip_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['industry'] = this.industry;
    data['mobile'] = this.mobile;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['address'] = this.address;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip_code'] = this.zipCode;
    data['status'] = this.status;
    return data;
  }
}

class Photo {
  int? id;
  Null? originalName;
  String? name;
  int? forceDownload;
  String? filePath;
  String? createdAt;

  Photo(
      {this.id,
      this.originalName,
      this.name,
      this.forceDownload,
      this.filePath,
      this.createdAt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalName = json['original_name'];
    name = json['name'];
    forceDownload = json['force_download'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['original_name'] = this.originalName;
    data['name'] = this.name;
    data['force_download'] = this.forceDownload;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    return data;
  }
}