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
  late int id;
  late String firstName;
  late String lastName;
  late String mobile;
  late String email;
  late int createdBy;
  late int updatedBy;
  late int companyId;
  late int status;
  late int debts;
  late List<Orders> orders;

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
        orders.add(new Orders.fromJson(v));
      });
    }
  }
}

class Orders {
late  int id;
late  String orderNumber;
late  String total;
late  String paymentWhen;
 late String amountPaid;
 late String amountRemaining;
 late String status;
 late int requiresApproval;
 late int addressId;
late  int clientId;
late  int companyId;
late  int createdBy;
 late int updatedBy;
 late String createdAt;
late  String updatedAt;

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
