class FetchProfileModel {
  bool? status;
  String? message;
  UserProfileData? userProfileData;

  FetchProfileModel({this.status, this.message, this.userProfileData});

  FetchProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userProfileData = json['userProfileData'] != null ? new UserProfileData.fromJson(json['userProfileData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userProfileData != null) {
      data['userProfileData'] = this.userProfileData!.toJson();
    }
    return data;
  }
}

class UserProfileData {
  User? user;
  int? totalFollowers;
  int? totalFollowing;
  int? totalLikesOfVideoPost;

  UserProfileData({this.user, this.totalFollowers, this.totalFollowing, this.totalLikesOfVideoPost});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    totalFollowers = json['totalFollowers'];
    totalFollowing = json['totalFollowing'];
    totalLikesOfVideoPost = json['totalLikesOfVideoPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['totalFollowers'] = this.totalFollowers;
    data['totalFollowing'] = this.totalFollowing;
    data['totalLikesOfVideoPost'] = this.totalLikesOfVideoPost;
    return data;
  }
}

class User {
  String? name;
  String? userName;
  String? bio;
  String? gender;
  String? sub;
  String? image;
  String? countryFlagImage;
  String? country;
  bool? isVerified;
  bool? isFollow;
  bool? isFake;
  bool? isProfileImageBanned;


  
  User({this.name, this.userName, this.bio, this.gender, this.sub, this.image, this.countryFlagImage, this.country, this.isVerified, this.isFollow, this.isFake, this.isProfileImageBanned});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['userName'];
    bio = json['bio'];
    gender = json['gender'];
    sub = json['sub']?.toString();
    image = json['image'];
    countryFlagImage = json['countryFlagImage'];
    country = json['country'];
    isVerified = json['isVerified'];
    isFollow = json['isFollow'];
    isFake = json['isFake'];
    isProfileImageBanned = json['isProfileImageBanned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['bio'] = this.bio;
    data['sub'] = this.sub;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['countryFlagImage'] = this.countryFlagImage;
    data['country'] = this.country;
    data['isVerified'] = this.isVerified;
    data['isFollow'] = this.isFollow;
    data['isFake'] = this.isFake;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    return data;
  }
}
