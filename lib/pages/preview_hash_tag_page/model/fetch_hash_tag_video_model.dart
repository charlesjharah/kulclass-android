class FetchHashTagVideoModel {
  bool? status;
  String? message;
  List<VideoData>? data;

  FetchHashTagVideoModel({this.status, this.message, this.data});

  FetchHashTagVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VideoData>[];
      json['data'].forEach((v) {
        data!.add(new VideoData.fromJson(v));
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

class VideoData {
  String? id;
  bool? isLike;
  int? totalLikes;
  int? totalComments;
  String? videoId;
  String? videoImage;
  String? videoUrl;
  String? caption;
  String? songId;
  String? createdAt;
  String? userId;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  bool? userIsFake;
  String? userImage;
  bool? isVerified;
  List<String>? hashTag;
  String? songTitle;
  String? songImage;
  String? songLink;
  String? singerName;

  VideoData(
      {this.id,
      this.isLike,
      this.totalLikes,
      this.totalComments,
      this.videoId,
      this.videoImage,
      this.videoUrl,
      this.caption,
      this.songId,
      this.createdAt,
      this.userId,
      this.isProfileImageBanned,
      this.name,
      this.userName,
      this.userIsFake,
      this.userImage,
      this.isVerified,
      this.hashTag,
      this.songTitle,
      this.songImage,
      this.songLink,
      this.singerName});

  VideoData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isLike = json['isLike'];
    totalLikes = json['totalLikes'];
    totalComments = json['totalComments'];
    videoId = json['videoId'];
    videoImage = json['videoImage'];
    videoUrl = json['videoUrl'];
    caption = json['caption'];
    songId = json['songId'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    userIsFake = json['userIsFake'];
    userImage = json['userImage'];
    isVerified = json['isVerified'];
    hashTag = json['hashTag'].cast<String>();
    songTitle = json['songTitle'];
    songImage = json['songImage'];
    songLink = json['songLink'];
    singerName = json['singerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['isLike'] = this.isLike;
    data['totalLikes'] = this.totalLikes;
    data['totalComments'] = this.totalComments;
    data['videoId'] = this.videoId;
    data['videoImage'] = this.videoImage;
    data['videoUrl'] = this.videoUrl;
    data['caption'] = this.caption;
    data['songId'] = this.songId;
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['userIsFake'] = this.userIsFake;
    data['userImage'] = this.userImage;
    data['isVerified'] = this.isVerified;
    data['hashTag'] = this.hashTag;
    data['songTitle'] = this.songTitle;
    data['songImage'] = this.songImage;
    data['songLink'] = this.songLink;
    data['singerName'] = this.singerName;
    return data;
  }
}
