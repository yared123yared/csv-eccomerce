class SaleReportModel {
  List<DataSaleReport>? data;

  SaleReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataSaleReport.fromJson(v));
      });
    }
  }
}

class DataSaleReport {
  late int id;
  late String orderNumber;
  late String createdAt;
  late String total;
  late String amountPaid;
  late String amountRemaining;
  late int clientId;
  late String status;
  Client? client;

  DataSaleReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    createdAt = json['created_at'];
    total = json['total'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    clientId = json['client_id'];
    status = json['status'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }
}

class Client {
  late int id;
  late String firstName;
  late String lastName;
  late String mobile;
  late String email;
  late int debts;
  late List<SaleReportModel> orders;

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    debts = json['debts'];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders.add(SaleReportModel.fromJson(v));
      });
    }
  }
}

class OrdersDate {
  late int id;
  late String orderNumber;
  late String total;
  late String paymentWhen;
  late String paymentMethod;
  late String typeOfWallet;
  late String transactionId;
  late String amountPaid;
  late String amountRemaining;
  late String status;
  late int requiresApproval;
  late int addressId;
  late int clientId;
  late int companyId;
  late int createdBy;
  late int updatedBy;
  late String createdAt;
  late String updatedAt;

  OrdersDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    total = json['total'];
    paymentWhen = json['payment_when'];
    paymentMethod = json['payment_method'];
    typeOfWallet = json['type_of_wallet'];
    transactionId = json['transaction_id'];
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

class Links {
  late String url;
  late String label;
  late bool active;

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
