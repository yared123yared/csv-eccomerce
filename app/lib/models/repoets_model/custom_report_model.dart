class CustomReportModel {
  List<DataCustomReport>? data;

  CustomReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new DataCustomReport.fromJson(v));
      });
    }
  }
}

class DataCustomReport {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  int? createdBy;
  int? updatedBy;
  int? companyId;
  int? status;
  int? debts;
  List<Orders>? orders;

  DataCustomReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    companyId = json['company_id'];
    status = json['status'];
    debts = json['debts'];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(new Orders.fromJson(v));
      });
    }
  }
}

class Orders {
  int? id;
  String? orderNumber;
  String? total;
  String? paymentWhen;
  String? amountPaid;
  String? amountRemaining;
  String? status;
  int? requiresApproval;
  int? addressId;
  int? clientId;
  int? companyId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    total = json['total'];
    paymentWhen = json['payment_when'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    status = json['status'];
    requiresApproval = json['requires_approval'];
    addressId = json['address_id'];
    clientId = json['client_id'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
