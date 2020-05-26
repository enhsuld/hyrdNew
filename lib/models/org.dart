import 'package:hyrd/models/car_model.dart';

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
