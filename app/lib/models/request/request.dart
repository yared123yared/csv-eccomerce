import 'cart.dart';

class Request {
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

  Request(
      {this.total,
      this.paymentWhen,
      this.paymentMethod,
      this.typeOfWallet,
      this.transactionId,
      this.amountPaid,
      this.amountRemaining,
      this.addressId,
      this.clientId,
      this.cart});

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['payment_when'] = this.paymentWhen;
    data['payment_method'] = this.paymentMethod;
    data['type_of_wallet'] = this.typeOfWallet;
    data['transaction_id'] = this.transactionId;
    data['amount_paid'] = this.amountPaid;
    data['amount_remaining'] = this.amountRemaining;
    data['address_id'] = this.addressId;
    data['client_id'] = this.clientId;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
