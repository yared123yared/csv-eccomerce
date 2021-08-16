import 'package:app/models/product/data.dart';

class CartLogic {
  final List<Data> products;
  CartLogic({required this.products});

  double getTotalPrice() {
    double total = 0;

    for (int i = 0; i < products.length; i++) {
      String value = products[i].price as String;
      total += double.parse(value) * products[i].order;
    }

    return total;
  }

  double getTaxedPrice() {
    double total = this.getTaxedPrice();
    double taxedValue = total - 20;
    return taxedValue;
  }
}
