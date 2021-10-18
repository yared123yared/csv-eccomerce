import 'package:app/models/client.dart';

class AllOrdersModel {
  List<DataAllOrders>? data;

  AllOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new DataAllOrders.fromJson(v));
      });
    }
  }
}

class CartItemFields {
  static final List<String> values = [id, quantity, prodID, orderID];
  static final String id = 'id';
  static final String quantity = 'quantity';
  static final String prodID = 'product_id';
  static final String orderID = 'order_id';
}

class CartItem {
  int? id;
  late int quantity;
  int? productId;
  int? orderId;
  CartItem({
    required this.id,
    required this.quantity,
    required this.productId,
    this.orderId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    return data;
  }

  Map<String, dynamic> toDbJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    return data;
  }

  CartItem.fromDB(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productId = json['product_id'];
    orderId = json['order_id'];
  }
}

class DataAllOrders {
  late int id;
  late String createdAt;
  late String total;
  late String amountPaid;
  late String orderNumber;
  // late String paymentWhen;
  late String amountRemaining;
  late String status;
  late int clientId;
  Client? client;
  List<ProductsA>? products;

  DataAllOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    total = json['total'];
    amountPaid = json['amount_paid'];
    orderNumber = json['order_number'];
    amountRemaining = json['amount_remaining'];
    // paymentWhen = json['payment_when'];
    status = json['status'];
    clientId = json['client_id'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(new ProductsA.fromJson(v));
      });
    }
  }
}

class ProductsA {
  late int id;
  late int orderId;
  late int productId;
  late int quantity;
  late String price;
  late String total;
  List<int>? attributes;
  late int companyId;
  late int createdBy;
  late int updatedBy;
  late String createdAt;
  late String updatedAt;
  List<ProductAttributes>? productAttributes;

  ProductsA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    attributes = json['attributes'].cast<int>();
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_attributes'] != null) {
      productAttributes = [];
      json['product_attributes'].forEach((v) {
        productAttributes?.add(new ProductAttributes.fromJson(v));
      });
    }
  }
}

class ProductAttributes {
  late String name;
  late String value;

  ProductAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }
}

// class Client {
//   late int id;
//   late String firstName;
//   late String lastName;
//   late String mobile;
//   late String email;
//   late int debts;
//   List<Orders>? orders;

//   Client.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     mobile = json['mobile'];
//     email = json['email'];
//     debts = json['debts'];
//     if (json['orders'] != null) {
//       orders = [];
//       json['orders'].forEach((v) {
//         orders?.add(new Orders.fromJson(v));
//       });
//     }
//   }
// }

// class Orders {
//   late int id;
//   late String orderNumber;
//   late String total;
//   late String paymentWhen;

//   late String amountPaid;
//   late String amountRemaining;
//   late String status;
//   late int requiresApproval;
//   late int addressId;
//   late int clientId;
//   late int companyId;
//   late int createdBy;
//   late int updatedBy;
//   late String createdAt;
//   late String updatedAt;

//   Orders.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderNumber = json['order_number'];
//     total = json['total'];
//     paymentWhen = json['payment_when'];

//     amountPaid = json['amount_paid'];
//     amountRemaining = json['amount_remaining'];
//     status = json['status'];
//     requiresApproval = json['requires_approval'];
//     addressId = json['address_id'];
//     clientId = json['client_id'];
//     companyId = json['company_id'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
// }
