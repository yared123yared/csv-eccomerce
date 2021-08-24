class PayMentContainerModel {
  List<DataPayment>? data;

  PayMentContainerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataPayment.fromJson(v));
      });
    }
  }
}

class DataPayment {
  late int id;
  late String date;
  late String amount;
  late int approved;
  late int denied;
  String? reasonDenied;
  late String status;
  Photo? photo;

  DataPayment.fromJson(Map<String, dynamic> json) {
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
