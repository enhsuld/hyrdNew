import 'package:hyrd/models/car_model.dart';

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
    return jsonList.map<PostModel>((obj) => PostModel.fromJson(obj)).toList();
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
