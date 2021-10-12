class SymbolModel {
  late int id;
  late String name;
  late String code;
  late String symbol;
  late int status;
  late String createdAt;

  SymbolModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}
