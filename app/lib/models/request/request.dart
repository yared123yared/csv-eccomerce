import 'package:app/models/OrdersDrawer/all_orders_model.dart';

import 'cart.dart';

class RequestFields {
  static final List<String> values = [
    /// Add all fields
    id, total, paymentWhen, paymentMethod, typeOfWallet, transactionId,
    amountPaid, amountRemaining, addressId, clientId,
    // type,isLocal
  ];
   static final List<String> values2 = [
    /// Add all fields
    idX, total, paymentWhen, paymentMethod, typeOfWallet, transactionId,
    amountPaid, amountRemaining, addressId, clientId,
    // type,isLocal
  ];
  static final String idX = "id";
  static final String id = '_id';
  static final String total = 'total';
  static final String paymentWhen = 'payment_when';
  static final String paymentMethod = 'payment_method';
  static final String typeOfWallet = 'type_of_wallet';
  static final String transactionId = 'transaction_id';
  static final String amountPaid = 'amount_paid';
  static final String amountRemaining = 'amount_remaining';
  static final String addressId = 'address_id';
  static final String clientId = 'client_id';
  // static final String type = 'type';
  // static final String isLocal = 'is_local';
}

class Request {
  int? id;
  int? total;
  String? paymentWhen;
  String? paymentMethod;
  String? typeOfWallet;
  String? transactionId;
  int? amountPaid;
  int? amountRemaining;
  int? addressId;
  int? clientId;
  List<Cart>? cart;
  List<CartItem>? cartItem;
  // String? type;
  // String? isLocal;

  Request({
    this.id,
    this.total,
    this.paymentWhen,
    this.paymentMethod,
    this.typeOfWallet,
    this.transactionId,
    this.amountPaid,
    this.amountRemaining,
    this.addressId,
    this.clientId,
    this.cart,
    this.cartItem,
    // this.type,
    // this.isLocal
  });

  Request.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    paymentWhen = json['payment_when'];
    paymentMethod = json['payment_method'];
    typeOfWallet = json['type_of_wallet'];
    transactionId = json['transaction_id'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    addressId = json['address_id'];
    clientId = json['client_id'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
  }
  Request.fromDB(Map<String, dynamic> json) {
    id = json['_id'];
    total = json[RequestFields.total];
    paymentWhen = json[RequestFields.paymentWhen];
    paymentMethod = json[RequestFields.paymentMethod];
    typeOfWallet = json[RequestFields.typeOfWallet];
    transactionId = json[RequestFields.transactionId];
    amountPaid = json[RequestFields.amountPaid];
    amountRemaining = json[RequestFields.amountRemaining];
    addressId = json[RequestFields.addressId];
    clientId = json[RequestFields.clientId];
    // type = json[RequestFields.type];
    // isLocal = json[RequestFields.isLocal];
  }
   Request.fromUpdateDB(Map<String, dynamic> json) {
    id = json['id'];
    total = json[RequestFields.total];
    paymentWhen = json[RequestFields.paymentWhen];
    paymentMethod = json[RequestFields.paymentMethod];
    typeOfWallet = json[RequestFields.typeOfWallet];
    transactionId = json[RequestFields.transactionId];
    amountPaid = json[RequestFields.amountPaid];
    amountRemaining = json[RequestFields.amountRemaining];
    addressId = json[RequestFields.addressId];
    clientId = json[RequestFields.clientId];
    // type = json[RequestFields.type];
    // isLocal = json[RequestFields.isLocal];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data['total'] = this.total;
    data['payment_when'] = this.paymentWhen;
    data['payment_method'] = this.paymentMethod;
    data['type_of_wallet'] = this.typeOfWallet;
    data['transaction_id'] = this.transactionId;
    data['amount_paid'] = this.amountPaid;
    data['amount_remaining'] = this.amountRemaining;
    data['address_id'] = this.addressId;
    data['client_id'] = this.clientId;
    if (this.cartItem != null) {
      data['cart'] = this.cartItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
   Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data['total'] = this.total;
    data['payment_when'] = this.paymentWhen;
    data['payment_method'] = this.paymentMethod;
    data['type_of_wallet'] = this.typeOfWallet;
    data['transaction_id'] = this.transactionId;
    data['amount_paid'] = this.amountPaid;
    data['amount_remaining'] = this.amountRemaining;
    data['address_id'] = this.addressId;
    data['client_id'] = this.clientId;
    // if (this.cartItem != null) {
    //   data['cart'] = this.cartItem!.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  Map<String, dynamic> toDb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[RequestFields.total] = this.total;
    data[RequestFields.paymentWhen] = this.paymentWhen;
    data[RequestFields.paymentMethod] = this.paymentMethod;
    data[RequestFields.typeOfWallet] = this.typeOfWallet;
    data[RequestFields.transactionId] = this.transactionId;
    data[RequestFields.amountPaid] = this.amountPaid;
    data[RequestFields.amountRemaining] = this.amountRemaining;
    data[RequestFields.addressId] = this.addressId;
    data[RequestFields.clientId] = this.clientId;
    // data[RequestFields.type] = this.type;
    // data[RequestFields.isLocal] = this.isLocal;
    return data;
  }
}
