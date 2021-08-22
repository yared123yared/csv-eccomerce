class ClientAutogenerated {
  late Clients clients;
  late int? draw;

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
  List<Docs>? documents;
  bool? isLocal = false;
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
    this.documents,
    this.isLocal,
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
      if (json['documents'] != null) {
        addresses = [];
        json['documents'].forEach((v) {
          documents!.add(new Docs.fromJson(v));
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
      // print(1);
      orderNumber = json['order_number'];
      // print(2);
      total = json['total'];
      // print(3);

      paymentWhen = json['payment_when'];
      // print(4);

      paymentMethod = json['payment_method'];
      // print(5);

      typeOfWallet = json['type_of_wallet'];
      // print(6);

      transactionId = json['transaction_id'];
      // print(7);

      amountPaid = json['amount_paid'];
      // print(8);

      amountRemaining = json['amount_remaining'];
      // print(9);

      status = json['status'];
      // print(10);

      requiresApproval = json['requires_approval'];
      // print(11);

      addressId = json['address_id'];
      // print(12);

      clientId = json['client_id'];
      // print(13);

      companyId = json['company_id'];
      // print(14);

      // createdBy = json['created_by'];
      // print(15);

      // updatedBy = json['updated_by'];
      // print(16);

      createdAt = json['created_at'];
      // print(17);

      updatedAt = json['updated_at'];
      // print(18);

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

class ClientFields {
  static final List<String> values = [
    /// Add all fields
    id, firstname, lastname, mobile, email, uploadedPhoto, type
  ];

  static final String id = '_id';
  static final String firstname = 'firstname';
  static final String lastname = 'lastname';
  static final String mobile = 'mobile';
  static final String email = 'email';
  static final String uploadedPhoto = 'uploaded_photo';
  static final String type = 'type';
}

class CreateEditData {
  String? id;
  late String firstName;
  late String lastName;
  late String mobile;
  late String email;
  late List<Addresses> addresses;
  late List<Docs>? documents;
  String? uploadedPhoto;
  String? type;
  CreateEditData({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.addresses,
    this.documents,
    this.uploadedPhoto,
    this.type,
  });

  CreateEditData copy({
    String? id,
    String? firstname,
    String? lastname,
    String? mobile,
    String? email,
    String? uploadedPhoto,
    String? type,
  }) =>
      CreateEditData(
        id: id ?? this.id,
        firstName: firstname ?? this.firstName,
        lastName: lastname ?? this.lastName,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        uploadedPhoto: uploadedPhoto ?? this.uploadedPhoto,
        addresses: this.addresses,
        documents: this.documents,
        type: this.type,
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['firstname'] = this.firstName;
    data['lastname'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['uploaded_photo'] = this.uploadedPhoto;
    data['type'] = this.type;
    return data;
  }

  CreateEditData.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    firstName = json['firstname'];
    lastName = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    uploadedPhoto = json['uploaded_photo'];
    type = json['type'];
    addresses = [];
    documents = [];
  }
}

class AddressFields {
  static final List<String> values = [
    id,
    clientId,
    streetAddress,
    zipCode,
    locality,
    city,
    state,
    country,
    isDefault,
    isBilling,
    companyId,
  ];

  static final String id = '_id';
  static final String clientId = 'client_id';
  static final String streetAddress = 'street_address';
  static final String zipCode = 'zip_code';
  static final String locality = 'locality';
  static final String city = 'city';
  static final String state = 'state';
  static final String country = 'country';
  static final String isDefault = 'is_default';
  static final String isBilling = 'is_billing';
  static final String companyId = 'company_id';
}

class Addresses {
  String? id;
  String? clientID;
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
    this.clientID,
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
      id = json['_id'].toString();
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
  Addresses.fromSqliteJson(Map<String, dynamic> json) {
    try {
      id = json['_id']?.toString();
      clientID = json['client_id']?.toString();
      streetAddress = json['street_address'];
      zipCode = json['zip_code'];
      locality = json['locality'];
      city = json['city'];
      state = json['state'];
      country = json['country'];
      isDefault = json['is_default'] == 1 ? true : false;
      isBilling = json['is_billing'] == 1 ? true : false;
      companyId = json['company_id']?.toString();
    } catch (e) {
      print("adreses---");
      print(e.toString());
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
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

  Map<String, dynamic> toSqliteJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // print("ad--1");
    if (this.id != null && this.id != ""&&this.id!="null") {
      print("this.id---${this.id == null}");
      print("this.id---${this.id != null}");
      print("${this.id}");
      data['_id'] = int.parse(this.id.toString());
    }
    // print("ad--2");

    data['client_id'] = int.parse(this.clientID.toString());
    // print("ad--3");

    data['street_address'] = this.streetAddress;
    // print("ad--4");

    data['zip_code'] = this.zipCode;
    // print("ad--5");

    data['locality'] = this.locality;
    // print("ad--6");

    data['city'] = this.city;
    // print("ad--7");

    data['state'] = this.state;
    // print("ad--8");

    data['country'] = this.country;
    // print("ad--9");

    if (this.isDefault != null) {
      data['is_default'] = this.isDefault! ? 1 : 0;
      // print("ad--10");
    } else {
      data['is_default'] = 0;
      // print("ad--11");
    }
    if (this.isBilling != null) {
      data['is_billing'] = this.isBilling! ? 1 : 0;
      // print("ad--12");
    } else {
      data['is_billing'] = 0;
      // print("ad--13");
    }
    data['company_id'] = this.companyId;
    // print("ad--14");

    return data;
  }
}

class Docs {
  String? id;
  late String name;
  late String path;
  String? clientID;
  Docs({
    this.id,
    required this.name,
    required this.path,
    this.clientID,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null && this.id != "" && this.id != "null") {
      data['_id'] = int.parse(this.id.toString());
    }
    data['name'] = this.name;
    data['path'] = this.path;
    if (this.clientID != null) {
      data['client_id'] = this.clientID;
    }
    return data;
  }

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    name = json['name'];
    path = json['path'];
    clientID = json['client_id'];
    // try {

    // } catch (e) {
    //   print("adreses---");
    //   print(e.toString());
    // }
  }
}

class DocFields {
  static final List<String> values = [
    id,
    name,
    path,
    clientId,
  ];
  static final String clientId = 'client_id';
  static final String name = 'name';
  static final String path = 'path';
  static final String id = '_id';
}

class SearchClientData {
  Client? client;

  SearchClientData({this.client});

  SearchClientData.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }
}
