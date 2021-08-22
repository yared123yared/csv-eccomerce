class PivotFields {
  static final List<String> values = [
    /// Add all fields
    productId, attributeId, value,unitId,unitName, createdAt, updatedAt
  ];

  static final String productId = 'product_id';
  static final String attributeId = 'attribute_id';
  static final String value = 'value';
  static final String unitId = 'unit_id';
  static final String unitName = 'unit_name';
  static final String createdAt = 'created_at';
  static final String updatedAt = 'updated_at';
}

class Pivot {
  int? productId;
  int? attributeId;
  String? value;
  int? unitId;
  String? unitName;
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
