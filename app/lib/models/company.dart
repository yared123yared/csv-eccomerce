import 'country.dart';

class Company {
  int? id;
  late String name;
  late String industry;
  late String mobile;
  String? fax;
  String? email;
  String? address;
  String? address2;
  String? city;
  String? state;
  Country? country;
  String? zipCode;
  int? status;
  String? creator;
  String? updater;

  Company(
      {this.id,
      required this.name,
      required this.industry,
      required this.mobile,
      this.fax,
      this.email,
      this.address,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.zipCode,
      this.status,
      this.creator,
      this.updater});

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
    print("Arrived at the company data conversion");
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    zipCode = json['zip_code'];
    status = json['status'];
    creator = json['creator'];
    updater = json['updater'];
    print("Completed companu data conversion");
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
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['zip_code'] = this.zipCode;
    data['status'] = this.status;
    data['creator'] = this.creator;
    data['updater'] = this.updater;
    return data;
  }
}
