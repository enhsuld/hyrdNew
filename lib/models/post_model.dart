class PostModel {
  int id;
  Org org;
  String title;
  String slug;
  String summary;
  String body;
  String coverImage;
  String publishedAt;
  String createdAt;
  String updatedAt;

  PostModel(
      {this.id,
        this.org,
        this.title,
        this.slug,
        this.summary,
        this.body,
        this.coverImage,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    org = json['org'] != null ? new Org.fromJson(json['org']) : null;
    title = json['title'];
    slug = json['slug'];
    summary = json['summary'];
    body = json['body'];
    coverImage = json['cover_image'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.org != null) {
      data['org'] = this.org.toJson();
    }
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['summary'] = this.summary;
    data['body'] = this.body;
    data['cover_image'] = this.coverImage;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<PostModel> fromJsonList(jsonList) {
    var data = jsonList['data'];
    return data.map<PostModel>((obj) => PostModel.fromJson(obj)).toList();
  }
}

class Org {
  int id;
  String name;
  String service;
  String avatar;
  String about;
  String address;
  String workHours;
  String email;
  String website;
  String phone;
  String latitude;
  String longitude;
  String createdAt;
  String updatedAt;
  Count count;

  Org(
      {this.id,
        this.name,
        this.service,
        this.avatar,
        this.about,
        this.address,
        this.workHours,
        this.email,
        this.website,
        this.phone,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.count});

  Org.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    service = json['service'];
    avatar = json['avatar'];
    about = json['about'];
    address = json['address'];
    workHours = json['workHours'];
    email = json['email'];
    website = json['website'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service'] = this.service;
    data['avatar'] = this.avatar;
    data['about'] = this.about;
    data['address'] = this.address;
    data['workHours'] = this.workHours;
    data['email'] = this.email;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.count != null) {
      data['count'] = this.count.toJson();
    }
    return data;
  }
}

class Count {
  int carAds;
  int posts;
  int followers;

  Count({this.carAds, this.posts, this.followers});

  Count.fromJson(Map<String, dynamic> json) {
    carAds = json['car-ads'];
    posts = json['posts'];
    followers = json['followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car-ads'] = this.carAds;
    data['posts'] = this.posts;
    data['followers'] = this.followers;
    return data;
  }
}