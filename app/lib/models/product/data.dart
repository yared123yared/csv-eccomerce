import 'package:app/models/category/categories.dart';
import 'package:app/models/product/photo.dart';
import 'package:app/models/product/product.dart';

import 'attributes.dart';
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
  List<Categories>? categories;
  List<Attributes>? attributes;
  int order = 0;
  //

  Data({
    this.id,
    this.name,
    this.model,
    this.price,
    this.quantity,
    this.manufacturerId,
    this.status,
    this.currencyId,
    this.brand,
    this.photos,
    this.currency,
    this.categories,
    this.attributes,
  });

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

    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
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
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
