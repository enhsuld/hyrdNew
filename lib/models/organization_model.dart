class OrganizationModel {
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
  Pivot pivot;
  List<Medias> medias;

  OrganizationModel(
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
        this.count,
        this.pivot,
        this.medias});

  OrganizationModel.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['medias'] != null) {
      medias = new List<Medias>();
      json['medias'].forEach((v) {
        medias.add(new Medias.fromJson(v));
      });
    }
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.medias != null) {
      data['medias'] = this.medias.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<OrganizationModel> fromJsonList(jsonList) {
    var data = jsonList['data'];
    return data.map<OrganizationModel>((obj) => OrganizationModel.fromJson(obj)).toList();
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

class Pivot {
  int followerId;
  int organizationId;
  String followedAt;
  Null unfollowedAt;
  bool notifFollower;

  Pivot(
      {this.followerId,
        this.organizationId,
        this.followedAt,
        this.unfollowedAt,
        this.notifFollower});

  Pivot.fromJson(Map<String, dynamic> json) {
    followerId = json['follower_id'];
    organizationId = json['organization_id'];
    followedAt = json['followed_at'];
    unfollowedAt = json['unfollowed_at'];
    notifFollower = json['notifFollower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follower_id'] = this.followerId;
    data['organization_id'] = this.organizationId;
    data['followed_at'] = this.followedAt;
    data['unfollowed_at'] = this.unfollowedAt;
    data['notifFollower'] = this.notifFollower;
    return data;
  }
}

class Medias {
  String original;
  String thumb;
  String optimized;
  List<String> responsiveImages;

  Medias({this.original, this.thumb, this.optimized, this.responsiveImages});

  Medias.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    thumb = json['thumb'];
    optimized = json['optimized'];
    responsiveImages = json['responsive_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['thumb'] = this.thumb;
    data['optimized'] = this.optimized;
    data['responsive_images'] = this.responsiveImages;
    return data;
  }
}