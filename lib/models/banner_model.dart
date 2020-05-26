class BannerModel {
  int id;
  String title;
  String banner;
  String link;
  Location location;
  String status;
  String startsAt;
  String endsAt;
  String createdAt;
  String updatedAt;

  BannerModel(
      {this.id,
        this.title,
        this.banner,
        this.link,
        this.location,
        this.status,
        this.startsAt,
        this.endsAt,
        this.createdAt,
        this.updatedAt});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    banner = json['banner'];
    link = json['link'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    status = json['status'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['banner'] = this.banner;
    data['link'] = this.link;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['status'] = this.status;
    data['starts_at'] = this.startsAt;
    data['ends_at'] = this.endsAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<BannerModel> fromJsonList(jsonList) {
    var data = jsonList['data'];
    return data.map<BannerModel>((obj) => BannerModel.fromJson(obj)).toList();
  }
}

class Location {
  int id;
  String title;
  int width;
  int height;
  String type;

  Location({this.id, this.title, this.width, this.height, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    width = json['width'];
    height = json['height'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['width'] = this.width;
    data['height'] = this.height;
    data['type'] = this.type;
    return data;
  }
}