class CollectionReportModel {
  List<DataCollection>? data;

  CollectionReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataCollection.fromJson(v));
      });
    }
  }
}

class DataCollection {
  int? id;
  String? createdAt;
  String? amountPaid;
  String? amountRemaining;
  String? paymentMethod;
  int? orderId;
  String? status;
  Order? order;

  DataCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    paymentMethod = json['payment_method'];
    orderId = json['order_id'];
    status = json['status'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }
}

class Order {
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
  Client? client;

  Order.fromJson(Map<String, dynamic> json) {
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




























// class CollectionReportModel {
//   List<DataCollectionReport>? data;

//   CollectionReportModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(DataCollectionReport.fromJson(v));
//       });
//     }
//   }
// }

// class DataCollectionReport {
//   int? id;
//   String? created_at;
//   String? amount_paid;
//   String? amount_remaining;
//   String? payment_method;
//   int? order_id;
//   String? status;
//   Order? order;

//   DataCollectionReport.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     created_at = json['created_at'];
//     amount_paid = json['amount_paid'];
//     amount_remaining = json['amount_remaining'];
//     payment_method = json['payment_method'];
//     order_id = json['order_id'];
//     status = json['status'];

//     order = json['order'] != null ? new Order.fromJson(json['order']) : null;
//   }
// }

// class Order {
//   late int id;
//   late String order_number;
//   late String total;
//   late String payment_when;
//   late String payment_method;
//   late String type_of_wallet;
//   late String transaction_id;
//   late String amount_paid;
//   late String amount_remaining;
//   late String status;
//   late int requires_approval;
//   late int address_id;
//   late int client_id;
//   late int company_id;
//   late int created_by;
//   late int updated_by;
//   late int created_at;
//   late int updated_at;
//   Client ? client;

//   Order.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     order_number = json['order_number'];
//     total = json['total'];
//     payment_when = json['payment_when'];
//     payment_method = json['payment_method'];
//     type_of_wallet = json['type_of_wallet'];
//     transaction_id = json['transaction_id'];
//     amount_paid = json['amount_paid'];
//     amount_remaining = json['amount_remaining'];
//     status = json['status'];
//     requires_approval = json['requires_approval'];
//     address_id = json['address_id'];
//     client_id = json['client_id'];
//     company_id = json['company_id'];
//     created_by = json['created_by'];
//     updated_by = json['updated_by'];
//     created_at = json['created_at'];
//     updated_at = json['updated_at'];
//     client =
//         json['client'] != null ? new Client.fromJson(json['client']) : null;
    
//   }
// }

// class Client{

// }
