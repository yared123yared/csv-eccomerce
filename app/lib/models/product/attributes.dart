import 'package:app/models/product/pivot.dart';

class Attributes {
  int? id;
  String? name;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Attributes(
      {this.id,
      this.name,
      this.companyId,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
