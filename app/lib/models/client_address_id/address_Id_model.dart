class AddressIdModel {
  late int id;
  late int clientId;
  late String streetAddress;
  late String zipCode;
  late String locality;
  late String city;
  late String state;
  late String country;
  late int isDefault;
  late int isBilling;
  late int companyId;

  AddressIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    streetAddress = json['street_address'];
    zipCode = json['zip_code'];
    locality = json['locality'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    isDefault = json['is_default'];
    isBilling = json['is_billing'];
    companyId = json['company_id'];
  }
}
