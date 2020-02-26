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
  String type;
  String firstname;
  String lastname;
  String regnum;
  String address;
  String countryCode;
  Null markName;
  Null modelName;
  String plateNumber;
  Null cabinNumber;
  String createdAt;
  String updatedAt;
  Setting setting;

  Data(
      {this.id,
        this.phone,
        this.type,
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
        this.setting});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    type = json['type'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['type'] = this.type;
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