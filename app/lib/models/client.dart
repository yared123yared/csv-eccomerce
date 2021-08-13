class ClientAutogenerated {
  late Clients clients;
  late int draw;

  ClientAutogenerated({
    required this.clients,
    required this.draw,
  });

  ClientAutogenerated.fromJson(Map<String, dynamic> json) {
    try {
      clients = (json['clients'] != null
          ? new Clients.fromJson(json['clients'])
          : null)!;
      draw = json['draw'];
    } catch (e) {
      print("17---");
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> clients = new Map<String, dynamic>();
    if (this.clients != null) {
      clients['clients'] = this.clients.toJson();
    }
    clients['draw'] = this.draw;
    return clients;
  }
}

class Clients {
  int? currentPage;
  List<Client>? client;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Clients(
      {this.currentPage,
      this.client,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Clients.fromJson(Map<String, dynamic> json) {
    try {
      currentPage = json['current_page'];
      if (json['data'] != null) {
        client = [];
        json['data'].forEach((v) {
          client!.add(new Client.fromJson(v));
        });
      }
      firstPageUrl = json['first_page_url'];
      from = json['from'];
      lastPage = json['last_page'];
      lastPageUrl = json['last_page_url'];
      if (json['links'] != null) {
        links = [];
        json['links'].forEach((v) {
          links!.add(new Links.fromJson(v));
        });
      }
      nextPageUrl = json['next_page_url'];
      path = json['path'];
      perPage = json['per_page'];
      prevPageUrl = json['prev_page_url'];
      to = json['to'];
      total = json['total'];
    } catch (e) {
      print("83---clients");
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> client = new Map<String, dynamic>();
    client['current_page'] = this.currentPage;
    if (this.client != null) {
      client['data'] = this.client!.map((v) => v.toJson()).toList();
    }
    client['first_page_url'] = this.firstPageUrl;
    client['from'] = this.from;
    client['last_page'] = this.lastPage;
    client['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      client['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    client['next_page_url'] = this.nextPageUrl;
    client['path'] = this.path;
    client['per_page'] = this.perPage;
    client['prev_page_url'] = this.prevPageUrl;
    client['to'] = this.to;
    client['total'] = this.total;
    return client;
  }
}

class Client {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? streetAddress;
  String? zipCode;
  String? locality;
  String? city;
  String? state;
  String? country;
  int? createdBy;
  int? updatedBy;
  int? companyId;
  int? status;
  int? debts;
  List<Orders>? orders;
  List<Addresses>? addresses;
  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.streetAddress,
    this.zipCode,
    this.locality,
    this.city,
    this.state,
    this.country,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.status,
    this.debts,
    this.orders,
    this.addresses,
  });

  Client.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      firstName = json['first_name'];
      lastName = json['last_name'];
      mobile = json['mobile'];
      email = json['email'];
      streetAddress = json['street_address'];
      zipCode = json['zip_code'];
      locality = json['locality'];
      city = json['city'];
      state = json['state'];
      country = json['country'];
      createdBy = json['created_by'];
      updatedBy = json['updated_by'];
      companyId = json['company_id'];
      status = json['status'];
      debts = json['debts'];
      if (json['orders'] != null) {
        orders = [];
        json['orders'].forEach((v) {
          orders!.add(new Orders.fromJson(v));
        });
      }
      if (json['addresses'] != null) {
        addresses = [];
        json['addresses'].forEach((v) {
          addresses!.add(new Addresses.fromJson(v));
        });
      }
    } catch (e) {
      print("client--182---");
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Client = new Map<String, dynamic>();
    try {
      Client['id'] = this.id;
      Client['first_name'] = this.firstName;
      Client['last_name'] = this.lastName;
      Client['mobile'] = this.mobile;
      Client['email'] = this.email;
      Client['street_address'] = this.streetAddress;
      Client['zip_code'] = this.zipCode;
      Client['locality'] = this.locality;
      Client['city'] = this.city;
      Client['state'] = this.state;
      Client['country'] = this.country;
      Client['created_by'] = this.createdBy;
      Client['updated_by'] = this.updatedBy;
      Client['company_id'] = this.companyId;
      Client['status'] = this.status;
      Client['debts'] = this.debts;
      if (this.orders != null) {
        Client['orders'] = this.orders!.map((v) => v.toJson()).toList();
      }
      if (this.addresses != null) {
        Client['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
      }
    } catch (e) {
      print("203------${e.toString()}");
    }
    return Client;
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

  Orders(
      {this.id,
      this.orderNumber,
      this.total,
      this.paymentWhen,
      this.paymentMethod,
      this.typeOfWallet,
      this.transactionId,
      this.amountPaid,
      this.amountRemaining,
      this.status,
      this.requiresApproval,
      this.addressId,
      this.clientId,
      this.companyId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Orders.fromJson(Map<String, dynamic> json) {
    try {
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
    } catch (e) {
      print("280--order----${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Client = new Map<String, dynamic>();
    Client['id'] = this.id;
    Client['order_number'] = this.orderNumber;
    Client['total'] = this.total;
    Client['payment_when'] = this.paymentWhen;
    Client['payment_method'] = this.paymentMethod;
    Client['type_of_wallet'] = this.typeOfWallet;
    Client['transaction_id'] = this.transactionId;
    Client['amount_paid'] = this.amountPaid;
    Client['amount_remaining'] = this.amountRemaining;
    Client['status'] = this.status;
    Client['requires_approval'] = this.requiresApproval;
    Client['address_id'] = this.addressId;
    Client['client_id'] = this.clientId;
    Client['company_id'] = this.companyId;
    Client['created_by'] = this.createdBy;
    Client['updated_by'] = this.updatedBy;
    Client['created_at'] = this.createdAt;
    Client['updated_at'] = this.updatedAt;
    return Client;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    try {
      url = json['url'];
      label = json['label'];
      active = json['active'];
    } catch (e) {
      print("321---links");
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Client = new Map<String, dynamic>();
    Client['url'] = this.url;
    Client['label'] = this.label;
    Client['active'] = this.active;
    return Client;
  }
}

class CreateEditData {
  String? id;
  String firstName;
  String lastName;
  String mobile;
  String email;
  List<Addresses> addresses;
  List<Docs>? documents;
  String? uploadedPhoto;
  CreateEditData({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.addresses,
    this.documents,
    this.uploadedPhoto,
  });
}

class Addresses {
  String? id;
  String? streetAddress;
  String? zipCode;
  String? locality;
  String? city;
  String? state;
  late String country;
  bool? isDefault;
  bool? isBilling;
  String? companyId;

  Addresses({
    this.id,
    this.streetAddress,
    this.zipCode,
    this.locality,
    this.city,
    this.state,
    required this.country,
    this.isDefault,
    this.isBilling,
    this.companyId,
  });

  Addresses.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'].toString();
      streetAddress = json['street_address'];
      zipCode = json['zip_code'];
      locality = json['locality'];
      city = json['city'];
      state = json['state'];
      country = json['country'];
      isDefault = json['is_default'] == 1 ? true : false;
      isBilling = json['is_billing'] == 1 ? true : false;
      companyId = json['company_id'].toString();
    } catch (e) {
      print("adreses---");
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street_address'] = this.streetAddress;
    data['zip_code'] = this.zipCode;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['is_default'] = this.isDefault;
    data['is_billing'] = this.isBilling;
    data['company_id'] = this.companyId;
    return data;
  }
}

class Docs {
  String name;
  String path;
  Docs({
    required this.name,
    required this.path,
  });
}
