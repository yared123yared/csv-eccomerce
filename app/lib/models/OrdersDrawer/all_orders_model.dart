class AllOrdersModel {
  List<DataAllOrders>? data;
  int? total;
  

  AllOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new DataAllOrders.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class DataAllOrders {
  int? id;
  String? createdAt;
  String? total;
  String? amountPaid;
  String? orderNumber;
  String? amountRemaining;
  String? status;
  int? clientId;
  Client? client;

  DataAllOrders.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  int? debts;
  List<Orders>? orders;

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
  String? paymentMethod;
  String? typeOfWallet;
  String? transactionId;
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
