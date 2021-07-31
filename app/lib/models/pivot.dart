class Pivot {
  late int categoryId;
  late int attributeId;
  late String value;
   int? unitId;
   String? unitName;

  Pivot({
    required this.categoryId,
    required this.attributeId,
    required this.value,
     this.unitId,
     this.unitName,
  });

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    attributeId = json['attribute_id'];
    value = json['value'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['attribute_id'] = this.attributeId;
    data['value'] = this.value;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    return data;
  }
}
