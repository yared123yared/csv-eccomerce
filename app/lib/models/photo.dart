class Photo {
  int? id;
  Null? originalName;
  String? name;
  int? forceDownload;
  String? filePath;
  String? createdAt;

  Photo(
      {this.id,
      this.originalName,
      this.name,
      this.forceDownload,
      this.filePath,
      this.createdAt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalName = json['original_name'];
    name = json['name'];
    forceDownload = json['force_download'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['original_name'] = this.originalName;
    data['name'] = this.name;
    data['force_download'] = this.forceDownload;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    return data;
  }
}
