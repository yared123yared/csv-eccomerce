class ParentCategory {
  int? id;
  int? parentId;
  late String name;
  late String code;
  late String slug;
  int? status;
  int? companyId;
  int? createdBy;
  int? updatedBy;
  late String createdAt;
  late String updatedAt;
  late String fullName;

  ParentCategory({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.slug,
    required this.status,
    required this.companyId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.fullName,
  });

  ParentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    code = json['code'];
    slug = json['slug'];
    status = json['status'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    // parentCategory = json['parent_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['company_id'] = this.companyId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    // data['parent_category'] = this.parentCategory;
    return data;
  }
}
