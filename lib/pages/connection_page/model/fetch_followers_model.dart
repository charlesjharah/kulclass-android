class FetchFollowersModel {
  bool? status;
  String? message;
  List<FollowersData>? followerFollowing;

  FetchFollowersModel({this.status, this.message, this.followerFollowing});

  FetchFollowersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['followerFollowing'] != null) {
      followerFollowing = <FollowersData>[];
      json['followerFollowing'].forEach((v) {
        followerFollowing!.add(new FollowersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.followerFollowing != null) {
      data['followerFollowing'] = this.followerFollowing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowersData {
  String? id;
  FromUserId? fromUserId;
  String? toUserId;
  String? createdAt;
  String? updatedAt;

  FollowersData({this.id, this.fromUserId, this.toUserId, this.createdAt, this.updatedAt});

  FollowersData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fromUserId = json['fromUserId'] != null ? new FromUserId.fromJson(json['fromUserId']) : null;
    toUserId = json['toUserId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.fromUserId != null) {
      data['fromUserId'] = this.fromUserId!.toJson();
    }
    data['toUserId'] = this.toUserId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class FromUserId {
  String? id;
  String? name;
  String? userName;
  String? image;
  bool? isProfileImageBanned;
  bool? isFake;
  bool? isVerified;

  FromUserId({this.id, this.name, this.userName, this.image, this.isProfileImageBanned, this.isFake, this.isVerified});

  FromUserId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isProfileImageBanned = json['isProfileImageBanned'];
    isFake = json['isFake'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['isFake'] = this.isFake;
    data['isVerified'] = this.isVerified;
    return data;
  }
}
