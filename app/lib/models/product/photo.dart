class Photos {
  int? id;
  int? referenceId;
  String? referenceType;
  String? name;
  int? forceDownload;
  String? filePath;
  String? createdAt;

  Photos(
      {this.id,
      this.referenceId,
      this.referenceType,
      this.name,
      this.forceDownload,
      this.filePath,
      this.createdAt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    referenceType = json['reference_type'];
    name = json['name'];
    forceDownload = json['force_download'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['reference_type'] = this.referenceType;
    data['name'] = this.name;
    data['force_download'] = this.forceDownload;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    return data;
  }
}
