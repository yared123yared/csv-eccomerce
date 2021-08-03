class Brand {
  int? id;
  String? name;
  int? companyId;
  String? createdAt;
  String? updatedAt;

  Brand({this.id, this.name, this.companyId, this.createdAt, this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
