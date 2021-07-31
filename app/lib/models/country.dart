class Country {
  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  String? phonecode;
  int? status;
  String? createdAt;

  Country(
      {this.id,
      this.iso,
      this.name,
      this.nicename,
      this.iso3,
      this.numcode,
      this.phonecode,
      this.status,
      this.createdAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    phonecode = json['phonecode'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso'] = this.iso;
    data['name'] = this.name;
    data['nicename'] = this.nicename;
    data['iso3'] = this.iso3;
    data['numcode'] = this.numcode;
    data['phonecode'] = this.phonecode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
