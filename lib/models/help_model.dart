class HelpModel {
  int id;
  String title;
  String subtitle;
  String body;
  String createdAt;
  String updatedAt;

  HelpModel(
      {this.id,
      this.title,
      this.subtitle,
      this.body,
      this.createdAt,
      this.updatedAt});

  HelpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? "";
    subtitle = json['subtitle'] ?? "";
    body = json['body'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<HelpModel> fromJsonList(jsonList) {
    var data = jsonList['data'];
    return data.map<HelpModel>((obj) => HelpModel.fromJson(obj)).toList();
  }
}
