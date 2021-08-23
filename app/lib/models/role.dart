class Role {
  int? id;
  late String name;

  Role({this.id, required this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    print("completed role data conversion");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
