class RecentOrderModel {
  List<RecentOrderData>? data;

  RecentOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new RecentOrderData.fromJson(v));
      });
    }
  }
}

class RecentOrderData {
  late int id;
  late String createdAt;
  late String total;
  late String amountPaid;
  late String orderNumber;
  late String amountRemaining;
  late String status;
  late int clientId;
  Client? client;

  RecentOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    total = json['total'];
    amountPaid = json['amount_paid'];
    orderNumber = json['order_number'];
    amountRemaining = json['amount_remaining'];
    status = json['status'];
    clientId = json['client_id'];
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
  List<RecentOrders>? orders;

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
        orders?.add(new RecentOrders.fromJson(v));
      });
    }
  }
}

class RecentOrders {
  late int id;
  late String orderNumber;
  late String total;
  late String paymentWhen;
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

  RecentOrders .fromJson(Map<String, dynamic> json) {
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
