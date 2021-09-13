class CartFields {
  static final List<String> values = [
    /// Add all fields
    prodID, id, amountInCart,
  ];

  static final String id = 'id';
  static final String amountInCart = 'amount_in_cart';
  static final String prodID = '_prod_id';
}

class Cart {
  int? id;
  int? amountInCart;
  int? prodID;

  List<int>? selectedAttributes;

  Cart({
    this.id,
    this.amountInCart,
    this.selectedAttributes,
    this.prodID,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amountInCart = json['amountInCart'];
    selectedAttributes = json['selectedAttributes'].cast<int>();
  }
  Cart.fromDb(Map<String, dynamic> json) {
    id = json['id'];
    amountInCart = json['amount_in_cart'];
    prodID = json['_prod_id'];
    // selectedAttributes = json['selectedAttributes'].cast<int>();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amountInCart'] = this.amountInCart;
    data['selectedAttributes'] = this.selectedAttributes;
    return data;
  }

  Map<String, dynamic> toSqliteJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount_in_cart'] = this.amountInCart;
    data['_prod_id'] = this.prodID;

    // data['selectedAttributes'] = this.selectedAttributes;
    return data;
  }
}
