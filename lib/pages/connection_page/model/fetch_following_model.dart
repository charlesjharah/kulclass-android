class FetchFollowingModel {
  bool? status;
  String? message;
  List<FollowingData>? followerFollowing;

  FetchFollowingModel({this.status, this.message, this.followerFollowing});

  FetchFollowingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['followerFollowing'] != null) {
      followerFollowing = <FollowingData>[];
      json['followerFollowing'].forEach((v) {
        followerFollowing!.add(new FollowingData.fromJson(v));
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

class FollowingData {
  String? id;
  String? fromUserId;
  ToUserId? toUserId;
  String? createdAt;
  String? updatedAt;

  FollowingData({this.id, this.fromUserId, this.toUserId, this.createdAt, this.updatedAt});

  FollowingData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'] != null ? new ToUserId.fromJson(json['toUserId']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['fromUserId'] = this.fromUserId;
    if (this.toUserId != null) {
      data['toUserId'] = this.toUserId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ToUserId {
  String? id;
  String? name;
  String? userName;
  String? image;
  bool? isProfileImageBanned;
  bool? isFake;
  bool? isVerified;

  ToUserId({this.id, this.name, this.userName, this.image, this.isProfileImageBanned, this.isFake, this.isVerified});

  ToUserId.fromJson(Map<String, dynamic> json) {
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
