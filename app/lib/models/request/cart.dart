class Cart {
  int? id;
  int? amountInCart;
  List<int>? selectedAttributes;

  Cart({this.id, this.amountInCart, this.selectedAttributes});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amountInCart = json['amountInCart'];
    selectedAttributes = json['selectedAttributes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amountInCart'] = this.amountInCart;
    data['selectedAttributes'] = this.selectedAttributes;
    return data;
  }
}
