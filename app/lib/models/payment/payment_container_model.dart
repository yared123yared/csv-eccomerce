class PayMentContainerModel {
  List<Data>? data;

  late int total;

  PayMentContainerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }

    total = json['total'] ;
  }
}

class Data {
  int? id;
  String? date;
  String? amount;
  int? approved;
  int? denied;
  String? reasonDenied;
  String? status;
  Photo? photo;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    amount = json['amount'];
    approved = json['approved'];
    denied = json['denied'];
    reasonDenied = json['reason_denied'];
    status = json['status'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
  }
}

class Photo {
  late int id;
  late int referenceId;
  late String referenceType;
  late String name;
  late int forceDownload;
  late String filePath;

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    referenceType = json['reference_type'];
    name = json['name'];
    forceDownload = json['force_download'];
    filePath = json['file_path'];
  }
}
