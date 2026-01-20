import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));
String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  EditProfileModel({
    bool? status,
    String? message,
    User? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  EditProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _status;
  String? _message;
  User? _user;
  EditProfileModel copyWith({
    bool? status,
    String? message,
    User? user,
  }) =>
      EditProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );
  bool? get status => _status;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    CoinPlan? coinPlan,
    String? id,
    LocationCoordinates? locationCoordinates,
    String? name,
    String? userName,
    String? image,
    String? gender,
    String? bio,
    int? age,
    String? countryFlagImage,
    String? country,
    String? ipAddress,
    int? coin,
    int? receivedCoin,
    int? purchasedCoin,
    int? receivedGift,
    String? uniqueId,
    String? email,
    String? mobileNumber,
    String? identity,
    String? fcmToken,
    String? date,
    bool? isLive,
    dynamic liveHistoryId,
    bool? isBlock,
    bool? isFake,
    bool? isVerified,
    bool? isPurchased,
    int? loginType,
    String? createdAt,
    String? updatedAt,
  }) {
    _coinPlan = coinPlan;
    _id = id;
    _locationCoordinates = locationCoordinates;
    _name = name;
    _userName = userName;
    _image = image;
    _gender = gender;
    _bio = bio;
    _age = age;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _ipAddress = ipAddress;
    _coin = coin;
    _receivedCoin = receivedCoin;
    _purchasedCoin = purchasedCoin;
    _receivedGift = receivedGift;
    _uniqueId = uniqueId;
    _email = email;
    _mobileNumber = mobileNumber;
    _identity = identity;
    _fcmToken = fcmToken;
    _date = date;
    _isLive = isLive;
    _liveHistoryId = liveHistoryId;
    _isBlock = isBlock;
    _isFake = isFake;
    _isVerified = isVerified;
    _isPurchased = isPurchased;
    _loginType = loginType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _coinPlan = json['coinPlan'] != null ? CoinPlan.fromJson(json['coinPlan']) : null;
    _id = json['_id'];
    _locationCoordinates =
        json['locationCoordinates'] != null ? LocationCoordinates.fromJson(json['locationCoordinates']) : null;
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _gender = json['gender'];
    _bio = json['bio'];
    _age = json['age'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _ipAddress = json['ipAddress'];
    _coin = json['coin'];
    _receivedCoin = json['receivedCoin'];
    _purchasedCoin = json['purchasedCoin'];
    _receivedGift = json['receivedGift'];
    _uniqueId = json['uniqueId'];
    _email = json['email'];
    _mobileNumber = json['mobileNumber'];
    _identity = json['identity'];
    _fcmToken = json['fcmToken'];
    _date = json['date'];
    _isLive = json['isLive'];
    _liveHistoryId = json['liveHistoryId'];
    _isBlock = json['isBlock'];
    _isFake = json['isFake'];
    _isVerified = json['isVerified'];
    _isPurchased = json['isPurchased'];
    _loginType = json['loginType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  CoinPlan? _coinPlan;
  String? _id;
  LocationCoordinates? _locationCoordinates;
  String? _name;
  String? _userName;
  String? _image;
  String? _gender;
  String? _bio;
  int? _age;
  String? _countryFlagImage;
  String? _country;
  String? _ipAddress;
  int? _coin;
  int? _receivedCoin;
  int? _purchasedCoin;
  int? _receivedGift;
  String? _uniqueId;
  String? _email;
  String? _mobileNumber;
  String? _identity;
  String? _fcmToken;
  String? _date;
  bool? _isLive;
  dynamic _liveHistoryId;
  bool? _isBlock;
  bool? _isFake;
  bool? _isVerified;
  bool? _isPurchased;
  int? _loginType;
  String? _createdAt;
  String? _updatedAt;
  User copyWith({
    CoinPlan? coinPlan,
    String? id,
    LocationCoordinates? locationCoordinates,
    String? name,
    String? userName,
    String? image,
    String? gender,
    String? bio,
    int? age,
    String? countryFlagImage,
    String? country,
    String? ipAddress,
    int? coin,
    int? receivedCoin,
    int? purchasedCoin,
    int? receivedGift,
    String? uniqueId,
    String? email,
    String? mobileNumber,
    String? identity,
    String? fcmToken,
    String? date,
    bool? isLive,
    dynamic liveHistoryId,
    bool? isBlock,
    bool? isFake,
    bool? isVerified,
    bool? isPurchased,
    int? loginType,
    String? createdAt,
    String? updatedAt,
  }) =>
      User(
        coinPlan: coinPlan ?? _coinPlan,
        id: id ?? _id,
        locationCoordinates: locationCoordinates ?? _locationCoordinates,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        gender: gender ?? _gender,
        bio: bio ?? _bio,
        age: age ?? _age,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        ipAddress: ipAddress ?? _ipAddress,
        coin: coin ?? _coin,
        receivedCoin: receivedCoin ?? _receivedCoin,
        purchasedCoin: purchasedCoin ?? _purchasedCoin,
        receivedGift: receivedGift ?? _receivedGift,
        uniqueId: uniqueId ?? _uniqueId,
        email: email ?? _email,
        mobileNumber: mobileNumber ?? _mobileNumber,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        date: date ?? _date,
        isLive: isLive ?? _isLive,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
        isBlock: isBlock ?? _isBlock,
        isFake: isFake ?? _isFake,
        isVerified: isVerified ?? _isVerified,
        isPurchased: isPurchased ?? _isPurchased,
        loginType: loginType ?? _loginType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  CoinPlan? get coinPlan => _coinPlan;
  String? get id => _id;
  LocationCoordinates? get locationCoordinates => _locationCoordinates;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  String? get gender => _gender;
  String? get bio => _bio;
  int? get age => _age;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  String? get ipAddress => _ipAddress;
  int? get coin => _coin;
  int? get receivedCoin => _receivedCoin;
  int? get purchasedCoin => _purchasedCoin;
  int? get receivedGift => _receivedGift;
  String? get uniqueId => _uniqueId;
  String? get email => _email;
  String? get mobileNumber => _mobileNumber;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  String? get date => _date;
  bool? get isLive => _isLive;
  dynamic get liveHistoryId => _liveHistoryId;
  bool? get isBlock => _isBlock;
  bool? get isFake => _isFake;
  bool? get isVerified => _isVerified;
  bool? get isPurchased => _isPurchased;
  int? get loginType => _loginType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_coinPlan != null) {
      map['coinPlan'] = _coinPlan?.toJson();
    }
    map['_id'] = _id;
    if (_locationCoordinates != null) {
      map['locationCoordinates'] = _locationCoordinates?.toJson();
    }
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['gender'] = _gender;
    map['bio'] = _bio;
    map['age'] = _age;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['ipAddress'] = _ipAddress;
    map['coin'] = _coin;
    map['receivedCoin'] = _receivedCoin;
    map['purchasedCoin'] = _purchasedCoin;
    map['receivedGift'] = _receivedGift;
    map['uniqueId'] = _uniqueId;
    map['email'] = _email;
    map['mobileNumber'] = _mobileNumber;
    map['identity'] = _identity;
    map['fcmToken'] = _fcmToken;
    map['date'] = _date;
    map['isLive'] = _isLive;
    map['liveHistoryId'] = _liveHistoryId;
    map['isBlock'] = _isBlock;
    map['isFake'] = _isFake;
    map['isVerified'] = _isVerified;
    map['isPurchased'] = _isPurchased;
    map['loginType'] = _loginType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

LocationCoordinates locationCoordinatesFromJson(String str) => LocationCoordinates.fromJson(json.decode(str));
String locationCoordinatesToJson(LocationCoordinates data) => json.encode(data.toJson());

class LocationCoordinates {
  LocationCoordinates({
    String? latitude,
    String? longitude,
  }) {
    _latitude = latitude;
    _longitude = longitude;
  }

  LocationCoordinates.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  String? _latitude;
  String? _longitude;
  LocationCoordinates copyWith({
    String? latitude,
    String? longitude,
  }) =>
      LocationCoordinates(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}

CoinPlan coinPlanFromJson(String str) => CoinPlan.fromJson(json.decode(str));
String coinPlanToJson(CoinPlan data) => json.encode(data.toJson());

class CoinPlan {
  CoinPlan({
    dynamic planStartDate,
    dynamic planEndDate,
    dynamic planId,
  }) {
    _planStartDate = planStartDate;
    _planEndDate = planEndDate;
    _planId = planId;
  }

  CoinPlan.fromJson(dynamic json) {
    _planStartDate = json['planStartDate'];
    _planEndDate = json['planEndDate'];
    _planId = json['planId'];
  }
  dynamic _planStartDate;
  dynamic _planEndDate;
  dynamic _planId;
  CoinPlan copyWith({
    dynamic planStartDate,
    dynamic planEndDate,
    dynamic planId,
  }) =>
      CoinPlan(
        planStartDate: planStartDate ?? _planStartDate,
        planEndDate: planEndDate ?? _planEndDate,
        planId: planId ?? _planId,
      );
  dynamic get planStartDate => _planStartDate;
  dynamic get planEndDate => _planEndDate;
  dynamic get planId => _planId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['planStartDate'] = _planStartDate;
    map['planEndDate'] = _planEndDate;
    map['planId'] = _planId;
    return map;
  }
}
