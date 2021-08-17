import 'attributes.dart';
import '../parent_category.dart';

class Categories {
  int? id;
  late String name;
  int? parentId;
  late String fullName;
  List<Attributes>? attributes;
  ParentCategory? parentCategory;

  Categories(
      {required this.id,
      required this.name,
      required this.parentId,
      required this.fullName,
      this.attributes,
      this.parentCategory});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    fullName = json['full_name'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(new Attributes.fromJson(v));
      });
    }
    parentCategory = json['parent_category'] != null
        ? new ParentCategory.fromJson(json['parent_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['full_name'] = this.fullName;
    if (this.attributes != null) {
      data['attributes'] = this.attributes?.map((v) => v.toJson()).toList();
    }
    if (this.parentCategory != null) {
      data['parent_category'] = this.parentCategory?.toJson();
    }
    return data;
  }
}
