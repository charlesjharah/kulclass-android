
class FetchLoginUserProfileModel {
  bool? status;
  String? message;
  User? user;

  FetchLoginUserProfileModel({this.status, this.message, this.user});

  FetchLoginUserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? userName;
  String? gender;
  String? bio;
  int? age;
  String? image;
  bool? isProfileImageBanned;
  String? countryFlagImage;
  String? country;
  String? ipAddress;
  int? coin;
  int? receivedCoin;
  int? purchasedCoin;
  int? receivedGift;
  int? totalWithdrawalCoin;
  int? totalWithdrawalAmount;
  String? uniqueId;
  String? email;
  String? mobileNumber;
  String? identity;
  String? fcmToken;
  String? date;
  String? lastlogin;
  bool? isLive;
  String? liveHistoryId;
  bool? isBlock;
  bool? isOnline;
  bool? isFake;
  bool? isVerified;
  int? loginType;
  int? sub;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.userName,
    this.gender,
    this.bio,
    this.age,
    this.image,
    this.isProfileImageBanned,
    this.countryFlagImage,
    this.country,
    this.ipAddress,
    this.coin,
    this.receivedCoin,
    this.purchasedCoin,
    this.receivedGift,
    this.totalWithdrawalCoin,
    this.totalWithdrawalAmount,
    this.uniqueId,
    this.email,
    this.mobileNumber,
    this.identity,
    this.fcmToken,
    this.date,
    this.lastlogin,
    this.isLive,
    this.liveHistoryId,
    this.isBlock,
    this.isOnline,
    this.isFake,
    this.isVerified,
    this.loginType,
    this.sub,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    gender = json['gender'];
    bio = json['bio'];
    age = json['age'];
    image = json['image'];
    isProfileImageBanned = json['isProfileImageBanned'];
    countryFlagImage = json['countryFlagImage'];
    country = json['country'];
    ipAddress = json['ipAddress'];
    coin = json['coin'];
    receivedCoin = json['receivedCoin'];
    purchasedCoin = json['purchasedCoin'];
    receivedGift = json['receivedGift'];
    totalWithdrawalCoin = json['totalWithdrawalCoin'];
    totalWithdrawalAmount = json['totalWithdrawalAmount'];
    uniqueId = json['uniqueId'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    identity = json['identity'];
    fcmToken = json['fcmToken'];
    date = json['date'];
    lastlogin = json['lastlogin'];
    isLive = json['isLive'];
    liveHistoryId = json['liveHistoryId'];
    isBlock = json['isBlock'];
    isOnline = json['isOnline'];
    isFake = json['isFake'];
    isVerified = json['isVerified'];
    loginType = json['loginType'];
    sub = json['sub'] is int ? json['sub'] : int.tryParse(json['sub']?.toString() ?? '');
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['age'] = this.age;
    data['image'] = this.image;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['countryFlagImage'] = this.countryFlagImage;
    data['country'] = this.country;
    data['ipAddress'] = this.ipAddress;
    data['coin'] = this.coin;
    data['receivedCoin'] = this.receivedCoin;
    data['purchasedCoin'] = this.purchasedCoin;
    data['receivedGift'] = this.receivedGift;
    data['totalWithdrawalCoin'] = this.totalWithdrawalCoin;
    data['totalWithdrawalAmount'] = this.totalWithdrawalAmount;
    data['uniqueId'] = this.uniqueId;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['identity'] = this.identity;
    data['fcmToken'] = this.fcmToken;
    data['date'] = this.date;
    data['lastlogin'] = this.lastlogin;
    data['isLive'] = this.isLive;
    data['liveHistoryId'] = this.liveHistoryId;
    data['isBlock'] = this.isBlock;
    data['isOnline'] = this.isOnline;
    data['isFake'] = this.isFake;
    data['isVerified'] = this.isVerified;
    data['loginType'] = this.loginType;
    data['sub'] = this.sub; // Added sub
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}