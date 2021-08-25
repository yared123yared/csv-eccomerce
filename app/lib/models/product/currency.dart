class CurrencyFields {
  static final List<String> values = [
    /// Add all fields
    id, name, code, name, symbol, status, companyId,createdAt,updatedAt
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String code = 'code';
  static final String symbol = 'symbol';
  static final String status = 'status';
  static final String companyId = 'company_id';
  static final String createdAt = 'created_at';
  static final String updatedAt = 'updated_at';


}

class Currency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  int? status;
  int? companyId;
  String? createdAt;
  String? updatedAt;

  Currency(
      {this.id,
      this.name,
      this.code,
      this.symbol,
      this.status,
      this.companyId,
      this.createdAt,
      this.updatedAt});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    status = json['status'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['symbol'] = this.symbol;
    data['status'] = this.status;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
