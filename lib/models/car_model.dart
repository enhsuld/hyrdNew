class CarModel {
  int id;
  User user;
  String name;
  Null condition;
  int price;
  String priceFormat;
  String description;
  String plateNumber;
  String cabinNumber;
  String countryName;
  String markName;
  String modelName;
  String type;
  String className;
  int manCount;
  int weight;
  int mass;
  String fuelType;
  int width;
  int height;
  int capacity;
  String motorNumber;
  String colorName;
  String axleCount;
  String certificateNumber;
  String importDate;
  String intent;
  String transmission;
  String ownerCountry;
  String ownerRegnum;
  String ownerType;
  String ownerFirstname;
  String ownerLastname;
  String ownerHomephone;
  String ownerWorkphone;
  String ownerHandphone;
  String ownerAddress;
  String archiveDate;
  String buildYear;
  String archiveFirstNumber;
  String wheelPosition;
  String length;
  String archiveNumber;
  int mileage;
  String drivetrain;
  String createdAt;
  String updatedAt;
  int views;
  PublishTariff publishTariff;
  List<Medias> medias;

  CarModel(
      {this.id,
      this.user,
      this.name,
      this.condition,
      this.price,
      this.priceFormat,
      this.description,
      this.plateNumber,
      this.cabinNumber,
      this.countryName,
      this.markName,
      this.modelName,
      this.type,
      this.className,
      this.manCount,
      this.weight,
      this.mass,
      this.fuelType,
      this.width,
      this.height,
      this.capacity,
      this.motorNumber,
      this.colorName,
      this.axleCount,
      this.certificateNumber,
      this.importDate,
      this.intent,
      this.transmission,
      this.ownerCountry,
      this.ownerRegnum,
      this.ownerType,
      this.ownerFirstname,
      this.ownerLastname,
      this.ownerHomephone,
      this.ownerWorkphone,
      this.ownerHandphone,
      this.ownerAddress,
      this.archiveDate,
      this.buildYear,
      this.archiveFirstNumber,
      this.wheelPosition,
      this.length,
      this.archiveNumber,
      this.mileage,
      this.drivetrain,
      this.createdAt,
      this.updatedAt,
      this.views,
      this.publishTariff,
      this.medias});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    name = json['name'];
    condition = json['condition'];
    price = json['price'];
    priceFormat = json['priceFormat'];
    description = json['description'];
    plateNumber = json['plateNumber'];
    cabinNumber = json['cabinNumber'];
    countryName = json['countryName'];
    markName = json['markName'];
    modelName = json['modelName'];
    type = json['type'];
    className = json['className'];
    manCount = json['manCount'];
    weight = json['weight'];
    mass = json['mass'];
    fuelType = json['fuelType'];
    width = json['width'];
    height = json['height'];
    capacity = json['capacity'];
    motorNumber = json['motorNumber'];
    colorName = json['colorName'];
    axleCount = json['axleCount'];
    certificateNumber = json['certificateNumber'];
    importDate = json['importDate'];
    intent = json['intent'];
    transmission = json['transmission'];
    ownerCountry = json['ownerCountry'];
    ownerRegnum = json['ownerRegnum'];
    ownerType = json['ownerType'];
    ownerFirstname = json['ownerFirstname'];
    ownerLastname = json['ownerLastname'];
    ownerHomephone = json['ownerHomephone'];
    ownerWorkphone = json['ownerWorkphone'];
    ownerHandphone = json['ownerHandphone'];
    ownerAddress = json['ownerAddress'];
    archiveDate = json['archiveDate'];
    buildYear = json['buildYear'];
    archiveFirstNumber = json['archiveFirstNumber'];
    wheelPosition = json['wheelPosition'];
    length = json['length'];
    archiveNumber = json['archiveNumber'];
    mileage = json['mileage'];
    drivetrain = json['drivetrain'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    views = json['views'];
    publishTariff = json['publish_tariff'] != null
        ? new PublishTariff.fromJson(json['publish_tariff'])
        : null;
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['name'] = this.name;
    data['condition'] = this.condition;
    data['price'] = this.price;
    data['priceFormat'] = this.priceFormat;
    data['description'] = this.description;
    data['plateNumber'] = this.plateNumber;
    data['cabinNumber'] = this.cabinNumber;
    data['countryName'] = this.countryName;
    data['markName'] = this.markName;
    data['modelName'] = this.modelName;
    data['type'] = this.type;
    data['className'] = this.className;
    data['manCount'] = this.manCount;
    data['weight'] = this.weight;
    data['mass'] = this.mass;
    data['fuelType'] = this.fuelType;
    data['width'] = this.width;
    data['height'] = this.height;
    data['capacity'] = this.capacity;
    data['motorNumber'] = this.motorNumber;
    data['colorName'] = this.colorName;
    data['axleCount'] = this.axleCount;
    data['certificateNumber'] = this.certificateNumber;
    data['importDate'] = this.importDate;
    data['intent'] = this.intent;
    data['transmission'] = this.transmission;
    data['ownerCountry'] = this.ownerCountry;
    data['ownerRegnum'] = this.ownerRegnum;
    data['ownerType'] = this.ownerType;
    data['ownerFirstname'] = this.ownerFirstname;
    data['ownerLastname'] = this.ownerLastname;
    data['ownerHomephone'] = this.ownerHomephone;
    data['ownerWorkphone'] = this.ownerWorkphone;
    data['ownerHandphone'] = this.ownerHandphone;
    data['ownerAddress'] = this.ownerAddress;
    data['archiveDate'] = this.archiveDate;
    data['buildYear'] = this.buildYear;
    data['archiveFirstNumber'] = this.archiveFirstNumber;
    data['wheelPosition'] = this.wheelPosition;
    data['length'] = this.length;
    data['archiveNumber'] = this.archiveNumber;
    data['mileage'] = this.mileage;
    data['drivetrain'] = this.drivetrain;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['views'] = this.views;
    if (this.publishTariff != null) {
      data['publish_tariff'] = this.publishTariff.toJson();
    }
    if (this.medias != null) {
      data['medias'] = this.medias.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<CarModel> fromJsonList(jsonList) {
    var data = jsonList['data'];
    return data.map<CarModel>((obj) => CarModel.fromJson(obj)).toList();
  }

  static List<CarModel> fromJsonListNoData(jsonList) {
    return jsonList.map<CarModel>((obj) => CarModel.fromJson(obj)).toList();
  }
}

class User {
  int id;
  String phone;
  int type;
  String typeString;
  String avatar;
  String firstname;
  String lastname;
  String regnum;
  String address;
  String countryCode;
  String markName;
  String modelName;
  String plateNumber;
  String cabinNumber;
  String createdAt;
  String updatedAt;
  Setting setting;
  Org org;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
  List<Medias> medias;

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
      this.count,
      this.medias});

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
    if (this.medias != null) {
      data['medias'] = this.medias.map((v) => v.toJson()).toList();
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

class PublishTariff {
  int id;
  int duration;
  int price;
  Null discount;
  Null description;
  Null publishGroup;

  PublishTariff(
      {this.id,
      this.duration,
      this.price,
      this.discount,
      this.description,
      this.publishGroup});

  PublishTariff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    price = json['price'];
    discount = json['discount'];
    description = json['description'];
    publishGroup = json['publish_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['publish_group'] = this.publishGroup;
    return data;
  }
}
