class User {
  User({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.role,
    this.credit,
    this.company,
    this.photo,
    this.locale,
    this.emailVerifiedAt,
    this.active,
    this.forcePwChange,
  });
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? phone;
  Role? role;
  String? credit;
  Company? company;
  Photo? photo;
  String? locale;
  String? emailVerifiedAt;
  int? active;
  int? forcePwChange;
  User.fromJson(Map<String, dynamic> json) {
    print("1");
    id = json['id'];
    print("2");
    title = json['title'];
    print("3");
    firstName = json['first_name'];
    print("4");
    lastName = json['last_name'];
    print("5");
    email = json['email'];
    print("6");
    username = json['username'];
    print("7");
    phone = json['phone'];
    print("8");
    role = Role.fromJson(json['role']);
    print("9");
    credit = json['credit'];
    print("10");
    company = Company.fromJson(json['company']);
    print("11");
    try {
      photo = Photo.fromJson(json['photo']);
    } catch (e) {
      print("-#####-");
      print(e);
    }
    print("12");
    locale = json['locale'];
    print("12");
    emailVerifiedAt = json['email_verified_at'];
    print("14");
    active = json['active'];
    print("15");
    forcePwChange = json['force_pw_change'];
    print("16");
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['username'] = username;
    _data['phone'] = phone;
    if (role != null) {
      _data['role'] = role!.toJson();
    }
    _data['credit'] = credit;
    if (company != null) {
      _data['company'] = company!.toJson();
    }
    if (photo != null) {
      _data['photo'] = photo!.toJson();
    }
    _data['locale'] = locale;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['active'] = active;
    _data['force_pw_change'] = forcePwChange;
    return _data;
  }
}
class Role {
  Role({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
class Company {
  Company({
    this.id,
    this.name,
    this.industry,
    this.mobile,
    this.fax,
    this.email,
    this.address,
    this.address_2,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.status,
    this.creator,
    this.updater,
  });
  int? id;
  String? name;
  String? industry;
  String? mobile;
  String? fax;
  String? email;
  String? address;
  String? address_2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  int? status;
  Map<String, dynamic>? creator;
  Map<String, dynamic>? updater;
  Company.fromJson(Map<String, dynamic> json) {
    print("c1");
    id = json['id'];
    print("c2");
    name = json['name'];
    print("c3");
    industry = json['industry'];
    print("c4");
    mobile = json['mobile'];
    print("c5");
    fax = json['fax'];
    print("c6");
    email = json['email'];
    print("c7");
    address = json['address'];
    print("c8");
    address_2 = json['address_2'];
    print("c9");
    city = json['city'];
    print("c10");
    state = null;
    print("c11");
    country = json['country'];
    print("c12");
    zipCode = json['zip_code'];
    print("c13");
    status = json['status'];
    print("c14");
    creator = json['creator'];
    print("c15");
    updater = json['updator'];
    print("c16");
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['industry'] = industry;
    _data['mobile'] = mobile;
    _data['fax'] = fax;
    _data['email'] = email;
    _data['address'] = address;
    _data['address_2'] = address_2;
    _data['city'] = city;
    _data['state'] = state;
    // if (country != null) {
      // _data['country'] = country!.toJson();
    // }
      _data['country'] = country;
    _data['zip_code'] = zipCode;
    _data['status'] = status;
    _data['creator'] = creator;
    _data['updater'] = updater;
    return _data;
  }
}
class Country {
  Country({
    required this.id,
    required this.iso,
    required this.name,
    required this.nicename,
    required this.iso3,
    required this.numcode,
    required this.phonecode,
    required this.status,
    required this.createdAt,
  });
  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  String? phonecode;
  int? status;
  String? createdAt;
  Country.fromJson(Map<String, dynamic> json) {
    print("ct1");
    id = json['id'];
    print("ct2");
    iso = json['iso'];
    print("ct3");
    name = json['name'];
    print("ct4");
    nicename = json['nicename'];
    print("ct5");
    iso3 = json['iso3'];
    print("ct6");
    numcode = json['numcode'];
    print("ct7");
    phonecode = json['phonecode'];
    print("ct8");
    status = json['status'];
    print("ct9");
    createdAt = json['created_at'];
    print("ct10");
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['iso'] = iso;
    _data['name'] = name;
    _data['nicename'] = nicename;
    _data['iso3'] = iso3;
    _data['numcode'] = numcode;
    _data['phonecode'] = phonecode;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    return _data;
  }
}
class Photo {
  Photo({
    this.id,
    this.originalName,
    this.name,
    this.forceDownload,
    this.filePath,
    this.createdAt,
  });
  int? id;
  String? originalName;
  String? name;
  int? forceDownload;
  String? filePath;
  String? createdAt;
  Photo.fromJson(Map<String, dynamic> json) {
    print("p1");
    id = json['id'];
    print("p2");
    originalName = json['original_name'];
    print("p3");
    name = json['name'];
    print("p4");
    forceDownload = json['force_download'];
    print("p5");
    filePath = json['file_path'];
    print("p6");
    createdAt = json['created_at'];
    print("p7");
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['original_name'] = originalName;
    _data['name'] = name;
    _data['force_download'] = forceDownload;
    _data['file_path'] = filePath;
    _data['created_at'] = createdAt;
    return _data;
  }
}