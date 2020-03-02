class ProfileModel {
  Data data;

  ProfileModel({this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String phone;
  int type;
  String typeString;
  String avatar;
  String firstname;
  String lastname;
  String regnum;
  Null address;
  String countryCode;
  Null markName;
  Null modelName;
  Null plateNumber;
  Null cabinNumber;
  String createdAt;
  String updatedAt;
  Setting setting;
  Org org;

  Data(
      {this.id,
        this.phone,
        this.type,
        this.typeString,
        this.avatar,
        this.firstname,
        this.lastname,
        this.regnum,
        this.address,
        this.countryCode,
        this.markName,
        this.modelName,
        this.plateNumber,
        this.cabinNumber,
        this.createdAt,
        this.updatedAt,
        this.setting,
        this.org});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    type = json['type'];
    typeString = json['typeString'];
    avatar = json['avatar'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    regnum = json['regnum'];
    address = json['address'];
    countryCode = json['country_code'];
    markName = json['markName'];
    modelName = json['modelName'];
    plateNumber = json['plateNumber'];
    cabinNumber = json['cabinNumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    setting =
    json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
    org = json['org'] != null ? new Org.fromJson(json['org']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['typeString'] = this.typeString;
    data['avatar'] = this.avatar;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['regnum'] = this.regnum;
    data['address'] = this.address;
    data['country_code'] = this.countryCode;
    data['markName'] = this.markName;
    data['modelName'] = this.modelName;
    data['plateNumber'] = this.plateNumber;
    data['cabinNumber'] = this.cabinNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.setting != null) {
      data['setting'] = this.setting.toJson();
    }
    if (this.org != null) {
      data['org'] = this.org.toJson();
    }
    return data;
  }
}

class Setting {
  bool autoLogin;
  bool mobileData;
  bool notifPosts;
  bool notifAds;
  bool notifVibration;
  bool notifSound;
  bool sendSearchToOrg;
  bool saveSearch;
  bool saveViews;

  Setting(
      {this.autoLogin,
        this.mobileData,
        this.notifPosts,
        this.notifAds,
        this.notifVibration,
        this.notifSound,
        this.sendSearchToOrg,
        this.saveSearch,
        this.saveViews});

  Setting.fromJson(Map<String, dynamic> json) {
    autoLogin = json['autoLogin'];
    mobileData = json['mobileData'];
    notifPosts = json['notifPosts'];
    notifAds = json['notifAds'];
    notifVibration = json['notifVibration'];
    notifSound = json['notifSound'];
    sendSearchToOrg = json['sendSearchToOrg'];
    saveSearch = json['saveSearch'];
    saveViews = json['saveViews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autoLogin'] = this.autoLogin;
    data['mobileData'] = this.mobileData;
    data['notifPosts'] = this.notifPosts;
    data['notifAds'] = this.notifAds;
    data['notifVibration'] = this.notifVibration;
    data['notifSound'] = this.notifSound;
    data['sendSearchToOrg'] = this.sendSearchToOrg;
    data['saveSearch'] = this.saveSearch;
    data['saveViews'] = this.saveViews;
    return data;
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