import 'package:app/models/product/photo.dart';
import 'package:app/models/product/product.dart';

import 'brand.dart';
import 'currency.dart';

class Data {
  int? id;
  String? name;
  String? model;
  String? price;
  int? quantity;
  int? manufacturerId;
  int? status;
  int? currencyId;
  Brand? brand;
  List<Photos>? photos;
  Currency? currency;

  Data(
      {this.id,
      this.name,
      this.model,
      this.price,
      this.quantity,
      this.manufacturerId,
      this.status,
      this.currencyId,
      this.brand,
      this.photos,
      this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
    quantity = json['quantity'];
    manufacturerId = json['manufacturer_id'];
    status = json['status'];
    currencyId = json['currency_id'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    if (json['photos'] != null) {
      var list = <Photos>[];
      photos = list;
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['manufacturer_id'] = this.manufacturerId;
    data['status'] = this.status;
    data['currency_id'] = this.currencyId;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    return data;
  }
}
