class SearchData {
  late  int draw;
  late int length;
  late String search;
  late int column;
  late String field;
  late bool relationship;
  late String relationshipField;
  late String dir;

  SearchData(
      {
      required this.draw,
      required this.length,
      required this.search,
      required this.column,
      required this.field,
      required this.relationship,
      required this.relationshipField,
      required this.dir});

  SearchData.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    length = json['length'];
    search = json['search'];
    column = json['column'];
    field = json['field'];
    relationship = json['relationship'];
    relationshipField = json['relationship_field'];
    dir = json['dir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw'] = this.draw;
    data['length'] = this.length;
    data['search'] = this.search;
    data['column'] = this.column;
    data['field'] = this.field;
    data['relationship'] = this.relationship;
    data['relationship_field'] = this.relationshipField;
    data['dir'] = this.dir;
    return data;
  }
}
