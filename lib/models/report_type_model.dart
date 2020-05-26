class ReportTypeModel {
  int id;
  String name;
  String slug;

  ReportTypeModel({this.id, this.name, this.slug});

  ReportTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }

  static List<ReportTypeModel> fromJsonList(jsonList) {
    //var data = jsonList['data'];
    return jsonList
        .map<ReportTypeModel>((obj) => ReportTypeModel.fromJson(obj))
        .toList();
  }
}