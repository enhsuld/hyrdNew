class CarModel {
  int _id;
  User _user;
  String _name;
  Null _condition;
  int _price;
  String _description;
  String _plateNumber;
  String _cabinNumber;
  String _countryName;
  String _markName;
  String _modelName;
  String _type;
  String _className;
  int _manCount;
  int _weight;
  int _mass;
  String _fuelType;
  int _width;
  int _height;
  int _capacity;
  String _motorNumber;
  String _colorName;
  String _axleCount;
  String _certificateNumber;
  String _importDate;
  String _intent;
  String _transmission;
  String _ownerCountry;
  String _ownerRegnum;
  String _ownerType;
  String _ownerFirstname;
  String _ownerLastname;
  String _ownerHomephone;
  String _ownerWorkphone;
  String _ownerHandphone;
  String _ownerAddress;
  String _archiveDate;
  String _buildYear;
  String _archiveFirstNumber;
  String _wheelPosition;
  String _length;
  String _archiveNumber;
  int _mileage;
  Null _drivetrain;
  String _createdAt;
  String _updatedAt;
  int _views;
  List<Reports> _reports;
  Null _publishTariff;
  List<Null> _medias;

  CarModel(
      {int id,
      User user,
      String name,
      Null condition,
      int price,
      String description,
      String plateNumber,
      String cabinNumber,
      String countryName,
      String markName,
      String modelName,
      String type,
      String className,
      int manCount,
      int weight,
      int mass,
      String fuelType,
      int width,
      int height,
      int capacity,
      String motorNumber,
      String colorName,
      String axleCount,
      String certificateNumber,
      String importDate,
      String intent,
      String transmission,
      String ownerCountry,
      String ownerRegnum,
      String ownerType,
      String ownerFirstname,
      String ownerLastname,
      String ownerHomephone,
      String ownerWorkphone,
      String ownerHandphone,
      String ownerAddress,
      String archiveDate,
      String buildYear,
      String archiveFirstNumber,
      String wheelPosition,
      String length,
      String archiveNumber,
      int mileage,
      Null drivetrain,
      String createdAt,
      String updatedAt,
      int views,
      List<Reports> reports,
      Null publishTariff,
      List<Null> medias}) {
    this._id = id;
    this._user = user;
    this._name = name;
    this._condition = condition;
    this._price = price;
    this._description = description;
    this._plateNumber = plateNumber;
    this._cabinNumber = cabinNumber;
    this._countryName = countryName;
    this._markName = markName;
    this._modelName = modelName;
    this._type = type;
    this._className = className;
    this._manCount = manCount;
    this._weight = weight;
    this._mass = mass;
    this._fuelType = fuelType;
    this._width = width;
    this._height = height;
    this._capacity = capacity;
    this._motorNumber = motorNumber;
    this._colorName = colorName;
    this._axleCount = axleCount;
    this._certificateNumber = certificateNumber;
    this._importDate = importDate;
    this._intent = intent;
    this._transmission = transmission;
    this._ownerCountry = ownerCountry;
    this._ownerRegnum = ownerRegnum;
    this._ownerType = ownerType;
    this._ownerFirstname = ownerFirstname;
    this._ownerLastname = ownerLastname;
    this._ownerHomephone = ownerHomephone;
    this._ownerWorkphone = ownerWorkphone;
    this._ownerHandphone = ownerHandphone;
    this._ownerAddress = ownerAddress;
    this._archiveDate = archiveDate;
    this._buildYear = buildYear;
    this._archiveFirstNumber = archiveFirstNumber;
    this._wheelPosition = wheelPosition;
    this._length = length;
    this._archiveNumber = archiveNumber;
    this._mileage = mileage;
    this._drivetrain = drivetrain;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._views = views;
    this._reports = reports;
    this._publishTariff = publishTariff;
    this._medias = medias;
  }

  int get id => _id;
  set id(int id) => _id = id;
  User get user => _user;
  set user(User user) => _user = user;
  String get name => _name;
  set name(String name) => _name = name;
  Null get condition => _condition;
  set condition(Null condition) => _condition = condition;
  int get price => _price;
  set price(int price) => _price = price;
  String get description => _description;
  set description(String description) => _description = description;
  String get plateNumber => _plateNumber;
  set plateNumber(String plateNumber) => _plateNumber = plateNumber;
  String get cabinNumber => _cabinNumber;
  set cabinNumber(String cabinNumber) => _cabinNumber = cabinNumber;
  String get countryName => _countryName;
  set countryName(String countryName) => _countryName = countryName;
  String get markName => _markName;
  set markName(String markName) => _markName = markName;
  String get modelName => _modelName;
  set modelName(String modelName) => _modelName = modelName;
  String get type => _type;
  set type(String type) => _type = type;
  String get className => _className;
  set className(String className) => _className = className;
  int get manCount => _manCount;
  set manCount(int manCount) => _manCount = manCount;
  int get weight => _weight;
  set weight(int weight) => _weight = weight;
  int get mass => _mass;
  set mass(int mass) => _mass = mass;
  String get fuelType => _fuelType;
  set fuelType(String fuelType) => _fuelType = fuelType;
  int get width => _width;
  set width(int width) => _width = width;
  int get height => _height;
  set height(int height) => _height = height;
  int get capacity => _capacity;
  set capacity(int capacity) => _capacity = capacity;
  String get motorNumber => _motorNumber;
  set motorNumber(String motorNumber) => _motorNumber = motorNumber;
  String get colorName => _colorName;
  set colorName(String colorName) => _colorName = colorName;
  String get axleCount => _axleCount;
  set axleCount(String axleCount) => _axleCount = axleCount;
  String get certificateNumber => _certificateNumber;
  set certificateNumber(String certificateNumber) =>
      _certificateNumber = certificateNumber;
  String get importDate => _importDate;
  set importDate(String importDate) => _importDate = importDate;
  String get intent => _intent;
  set intent(String intent) => _intent = intent;
  String get transmission => _transmission;
  set transmission(String transmission) => _transmission = transmission;
  String get ownerCountry => _ownerCountry;
  set ownerCountry(String ownerCountry) => _ownerCountry = ownerCountry;
  String get ownerRegnum => _ownerRegnum;
  set ownerRegnum(String ownerRegnum) => _ownerRegnum = ownerRegnum;
  String get ownerType => _ownerType;
  set ownerType(String ownerType) => _ownerType = ownerType;
  String get ownerFirstname => _ownerFirstname;
  set ownerFirstname(String ownerFirstname) => _ownerFirstname = ownerFirstname;
  String get ownerLastname => _ownerLastname;
  set ownerLastname(String ownerLastname) => _ownerLastname = ownerLastname;
  String get ownerHomephone => _ownerHomephone;
  set ownerHomephone(String ownerHomephone) => _ownerHomephone = ownerHomephone;
  String get ownerWorkphone => _ownerWorkphone;
  set ownerWorkphone(String ownerWorkphone) => _ownerWorkphone = ownerWorkphone;
  String get ownerHandphone => _ownerHandphone;
  set ownerHandphone(String ownerHandphone) => _ownerHandphone = ownerHandphone;
  String get ownerAddress => _ownerAddress;
  set ownerAddress(String ownerAddress) => _ownerAddress = ownerAddress;
  String get archiveDate => _archiveDate;
  set archiveDate(String archiveDate) => _archiveDate = archiveDate;
  String get buildYear => _buildYear;
  set buildYear(String buildYear) => _buildYear = buildYear;
  String get archiveFirstNumber => _archiveFirstNumber;
  set archiveFirstNumber(String archiveFirstNumber) =>
      _archiveFirstNumber = archiveFirstNumber;
  String get wheelPosition => _wheelPosition;
  set wheelPosition(String wheelPosition) => _wheelPosition = wheelPosition;
  String get length => _length;
  set length(String length) => _length = length;
  String get archiveNumber => _archiveNumber;
  set archiveNumber(String archiveNumber) => _archiveNumber = archiveNumber;
  int get mileage => _mileage;
  set mileage(int mileage) => _mileage = mileage;
  Null get drivetrain => _drivetrain;
  set drivetrain(Null drivetrain) => _drivetrain = drivetrain;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  int get views => _views;
  set views(int views) => _views = views;
  List<Reports> get reports => _reports;
  set reports(List<Reports> reports) => _reports = reports;
  Null get publishTariff => _publishTariff;
  set publishTariff(Null publishTariff) => _publishTariff = publishTariff;
  List<Null> get medias => _medias;
  set medias(List<Null> medias) => _medias = medias;

  CarModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _name = json['name'];
    _condition = json['condition'];
    _price = json['price'];
    _description = json['description'];
    _plateNumber = json['plateNumber'];
    _cabinNumber = json['cabinNumber'];
    _countryName = json['countryName'];
    _markName = json['markName'];
    _modelName = json['modelName'];
    _type = json['type'];
    _className = json['className'];
    _manCount = json['manCount'];
    _weight = json['weight'];
    _mass = json['mass'];
    _fuelType = json['fuelType'];
    _width = json['width'];
    _height = json['height'];
    _capacity = json['capacity'];
    _motorNumber = json['motorNumber'];
    _colorName = json['colorName'];
    _axleCount = json['axleCount'];
    _certificateNumber = json['certificateNumber'];
    _importDate = json['importDate'];
    _intent = json['intent'];
    _transmission = json['transmission'];
    _ownerCountry = json['ownerCountry'];
    _ownerRegnum = json['ownerRegnum'];
    _ownerType = json['ownerType'];
    _ownerFirstname = json['ownerFirstname'];
    _ownerLastname = json['ownerLastname'];
    _ownerHomephone = json['ownerHomephone'];
    _ownerWorkphone = json['ownerWorkphone'];
    _ownerHandphone = json['ownerHandphone'];
    _ownerAddress = json['ownerAddress'];
    _archiveDate = json['archiveDate'];
    _buildYear = json['buildYear'];
    _archiveFirstNumber = json['archiveFirstNumber'];
    _wheelPosition = json['wheelPosition'];
    _length = json['length'];
    _archiveNumber = json['archiveNumber'];
    _mileage = json['mileage'];
    _drivetrain = json['drivetrain'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _views = json['views'];
    if (json['reports'] != null) {
      _reports = new List<Reports>();
      // json['reports'].forEach((v) {
      //   _reports.add(new Reports.fromJson(v));
      // });
    }
    _publishTariff = json['publish_tariff'];
    if (json['medias'] != null) {
      _medias = new List<Null>();
      // json['medias'].forEach((v) {
      //   _medias.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    data['name'] = this._name;
    data['condition'] = this._condition;
    data['price'] = this._price;
    data['description'] = this._description;
    data['plateNumber'] = this._plateNumber;
    data['cabinNumber'] = this._cabinNumber;
    data['countryName'] = this._countryName;
    data['markName'] = this._markName;
    data['modelName'] = this._modelName;
    data['type'] = this._type;
    data['className'] = this._className;
    data['manCount'] = this._manCount;
    data['weight'] = this._weight;
    data['mass'] = this._mass;
    data['fuelType'] = this._fuelType;
    data['width'] = this._width;
    data['height'] = this._height;
    data['capacity'] = this._capacity;
    data['motorNumber'] = this._motorNumber;
    data['colorName'] = this._colorName;
    data['axleCount'] = this._axleCount;
    data['certificateNumber'] = this._certificateNumber;
    data['importDate'] = this._importDate;
    data['intent'] = this._intent;
    data['transmission'] = this._transmission;
    data['ownerCountry'] = this._ownerCountry;
    data['ownerRegnum'] = this._ownerRegnum;
    data['ownerType'] = this._ownerType;
    data['ownerFirstname'] = this._ownerFirstname;
    data['ownerLastname'] = this._ownerLastname;
    data['ownerHomephone'] = this._ownerHomephone;
    data['ownerWorkphone'] = this._ownerWorkphone;
    data['ownerHandphone'] = this._ownerHandphone;
    data['ownerAddress'] = this._ownerAddress;
    data['archiveDate'] = this._archiveDate;
    data['buildYear'] = this._buildYear;
    data['archiveFirstNumber'] = this._archiveFirstNumber;
    data['wheelPosition'] = this._wheelPosition;
    data['length'] = this._length;
    data['archiveNumber'] = this._archiveNumber;
    data['mileage'] = this._mileage;
    data['drivetrain'] = this._drivetrain;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['views'] = this._views;
    if (this._reports != null) {
      data['reports'] = this._reports.map((v) => v.toJson()).toList();
    }
    data['publish_tariff'] = this._publishTariff;
    if (this._medias != null) {
      //data['medias'] = this._medias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int _id;
  String _phone;
  String _type;
  String _firstname;
  String _lastname;
  String _regnum;
  String _address;
  String _countryCode;
  String _createdAt;
  String _updatedAt;

  User(
      {int id,
      String phone,
      String type,
      String firstname,
      String lastname,
      String regnum,
      String address,
      String countryCode,
      String createdAt,
      String updatedAt}) {
    this._id = id;
    this._phone = phone;
    this._type = type;
    this._firstname = firstname;
    this._lastname = lastname;
    this._regnum = regnum;
    this._address = address;
    this._countryCode = countryCode;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get type => _type;
  set type(String type) => _type = type;
  String get firstname => _firstname;
  set firstname(String firstname) => _firstname = firstname;
  String get lastname => _lastname;
  set lastname(String lastname) => _lastname = lastname;
  String get regnum => _regnum;
  set regnum(String regnum) => _regnum = regnum;
  String get address => _address;
  set address(String address) => _address = address;
  String get countryCode => _countryCode;
  set countryCode(String countryCode) => _countryCode = countryCode;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _phone = json['phone'];
    _type = json['type'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _regnum = json['regnum'];
    _address = json['address'];
    _countryCode = json['country_code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['phone'] = this._phone;
    data['type'] = this._type;
    data['firstname'] = this._firstname;
    data['lastname'] = this._lastname;
    data['regnum'] = this._regnum;
    data['address'] = this._address;
    data['country_code'] = this._countryCode;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class Reports {
  int _id;
  String _type;
  String _description;
  Null _user;
  String _createdAt;
  String _updatedAt;

  Reports(
      {int id,
      String type,
      String description,
      Null user,
      String createdAt,
      String updatedAt}) {
    this._id = id;
    this._type = type;
    this._description = description;
    this._user = user;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get type => _type;
  set type(String type) => _type = type;
  String get description => _description;
  set description(String description) => _description = description;
  Null get user => _user;
  set user(Null user) => _user = user;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  Reports.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _type = json['type'];
    _description = json['description'];
    _user = json['user'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['type'] = this._type;
    data['description'] = this._description;
    data['user'] = this._user;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
