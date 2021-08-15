class Pivot {
  int? productId;
  int? attributeId;
  String? value;
  Null? unitId;
  Null? unitName;
  String? createdAt;
  String? updatedAt;

  Pivot(
      {this.productId,
      this.attributeId,
      this.value,
      this.unitId,
      this.unitName,
      this.createdAt,
      this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributeId = json['attribute_id'];
    value = json['value'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['attribute_id'] = this.attributeId;
    data['value'] = this.value;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
