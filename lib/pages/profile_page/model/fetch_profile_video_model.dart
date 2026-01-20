class FetchProfileVideoModel {
  bool? status;
  String? message;
  List<ProfileVideoData>? data;

  FetchProfileVideoModel({this.status, this.message, this.data});

  FetchProfileVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProfileVideoData>[];
      json['data'].forEach((v) {
        data!.add(new ProfileVideoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileVideoData {
  String? id;
  String? caption;
  String? videoUrl;
  String? videoImage;
  String? songId;
  bool? isBanned;
  String? createdAt;
  int? totalLikes;
  bool? isLike;
  int? totalComments;
  int? totalViews;
  List<String>? hashTag;
  String? userId;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  String? userImage;
  bool? userIsFake;
  String? songTitle;
  String? songImage;
  String? songLink;
  String? singerName;

  ProfileVideoData(
      {this.id,
      this.caption,
      this.videoUrl,
      this.videoImage,
      this.songId,
      this.isBanned,
      this.createdAt,
      this.totalLikes,
      this.isLike,
      this.totalComments,
      this.totalViews,
      this.hashTag,
      this.userId,
      this.isProfileImageBanned,
      this.name,
      this.userName,
      this.userImage,
      this.userIsFake,
      this.songTitle,
      this.songImage,
      this.songLink,
      this.singerName});

  ProfileVideoData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    caption = json['caption'];
    videoUrl = json['videoUrl'];
    videoImage = json['videoImage'];
    songId = json['songId'];
    isBanned = json['isBanned'];
    createdAt = json['createdAt'];
    totalLikes = json['totalLikes'];
    isLike = json['isLike'];
    totalComments = json['totalComments'];
    totalViews = json['totalViews'];
    hashTag = json['hashTag'].cast<String>();
    userId = json['userId'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    userIsFake = json['userIsFake'];
    songTitle = json['songTitle'];
    songImage = json['songImage'];
    songLink = json['songLink'];
    singerName = json['singerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['caption'] = this.caption;
    data['videoUrl'] = this.videoUrl;
    data['videoImage'] = this.videoImage;
    data['songId'] = this.songId;
    data['isBanned'] = this.isBanned;
    data['createdAt'] = this.createdAt;
    data['totalLikes'] = this.totalLikes;
    data['isLike'] = this.isLike;
    data['totalComments'] = this.totalComments;
    data['totalViews'] = this.totalViews;
    data['hashTag'] = this.hashTag;
    data['userId'] = this.userId;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['userIsFake'] = this.userIsFake;
    data['songTitle'] = this.songTitle;
    data['songImage'] = this.songImage;
    data['songLink'] = this.songLink;
    data['singerName'] = this.singerName;
    return data;
  }
}
