class OrderDetailsAllModel {
  late int id;
  late String orderNumber;
  late String total;
  late String paymentMethod;
  late String amountPaid;
  late String amountRemaining;
  late String status;
  late List<Products> products;
  late String createdAt;
  late String updatedAt;

  OrderDetailsAllModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    total = json['total'];
    paymentMethod = json['payment_method'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    status = json['status'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Products {
  late int id;
  Order? order;
  Product? product;
  late int quantity;
  late String price;
  late String total;
  late String createdAt;
  late String updatedAt;
  Company? company;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }
}

class Order {
  late int id;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

class Product {
  late int id;
  late String name;
  late String description;
  late String model;
  late String sku;
  late String price;
  Currency? currency;
  late int quantity;
  late int minimum;
  late int subtract;
  late String stockStatus;
  late int stockStatusId;
  late String dateAvailable;
  late int status;
  late int sortOrder;
  Manufacturer? manufacturer;
  late List<Categories> categories;
  late List<Attributes> attributes;
  late List<Photos> photos;
  late String createdAt;
  late String updatedAt;
  late bool updated;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    model = json['model'];
    sku = json['sku'];
    price = json['price'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    quantity = json['quantity'];
    minimum = json['minimum'];
    subtract = json['subtract'];
    stockStatus = json['stock_status'];
    stockStatusId = json['stock_status_id'];
    dateAvailable = json['date_available'];
    status = json['status'];
    sortOrder = json['sort_order'];
    manufacturer = json['manufacturer'] != null
        ? new Manufacturer.fromJson(json['manufacturer'])
        : null;
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updated = json['updated'];
  }
}

class Currency {
  late int id;
  late String name;
  late String code;
  late String symbol;
  late int status;
  late String createdAt;

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}

class Manufacturer {
  late int id;
  late String name;
  late String createdAt;
  late String updatedAt;

  Manufacturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Categories {
  late int id;
  late int parentId;
  late String name;
  late String code;
  late String slug;
  late int status;
  late String createdAt;
  late String updatedAt;
  late String fullName;
  Pivot? pivot;
  ParentCategory? parentCategory;
  late int companyId;
  late int createdBy;
  late int updatedBy;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    code = json['code'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    parentCategory = json['parent_category'] != null
        ? new ParentCategory.fromJson(json['parent_category'])
        : null;
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
}

class Pivot {
  late int productId;
  late int categoryId;
  late String createdAt;
  late String updatedAt;

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ParentCategory {
  late int id;
  late int parentId;
  late String name;
  late String code;
  late String slug;
  late int status;
  late int companyId;
  late int createdBy;
  late int updatedBy;
  late String createdAt;
  late String updatedAt;
  late String fullName;
  ParentCategory? parentCategory;

  ParentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    code = json['code'];
    slug = json['slug'];
    status = json['status'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    parentCategory = json['parent_category'] != null
        ? new ParentCategory.fromJson(json['parent_category'])
        : null;
  }
}

class ParentCategoryDe {
  late int id;
  late String name;
  late String code;
  late String slug;
  late int status;
  late int companyId;
  late int createdBy;
  late int updatedBy;
  late String createdAt;
  late String updatedAt;
  late String fullName;

  ParentCategoryDe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    slug = json['slug'];
    status = json['status'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
  }
}

class Attributes {
  late int id;
  late String name;
  late int companyId;
  late String createdAt;
  late String updatedAt;
  Pivot? pivot;

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }
}

class PivotDe {
  late int productId;
  late int attributeId;
  late String value;
  late int id;
  late String createdAt;
  late String updatedAt;

  PivotDe.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributeId = json['attribute_id'];
    value = json['value'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Photos {
  late int id;
  late String name;
  late int forceDownload;
  late String filePath;
  late String createdAt;

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    forceDownload = json['force_download'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
  }
}

class Company {
  late int id;
  late String name;

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
