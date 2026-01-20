class FetchReelsModel {
  bool? status;
  String? message;
  List<Data>? data;

  FetchReelsModel({this.status, this.message, this.data});

  factory FetchReelsModel.fromJson(Map<String, dynamic> json) {
    List<Data>? dataList;
    if (json['data'] != null) {
      dataList = (json['data'] as List)
          .map((v) => Data.fromJson(v as Map<String, dynamic>))
          .toList();
    }

    return FetchReelsModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? caption;
  String? videoUrl;
  String? videoImage;
  String? songId;
  int? shareCount;
  bool? isFake;
  String? createdAt;
  List<String>? hashTag;
  String? userId;
  String? name;
  String? userName;
  String? userImage;
  bool? isVerified;
  bool? isLike;
  bool? isFollow;
  int? totalLikes;
  int? totalComments;
  String? time;
  bool? isProfileImageBanned;
  String? songTitle;
  String? songImage;
  String? songLink;
  String? singerName;

  Data(
      {this.id,
        this.caption,
        this.videoUrl,
        this.videoImage,
        this.songId,
        this.shareCount,
        this.isFake,
        this.createdAt,
        this.hashTag,
        this.userId,
        this.name,
        this.userName,
        this.userImage,
        this.isVerified,
        this.isLike,
        this.isFollow,
        this.totalLikes,
        this.totalComments,
        this.time,
        this.isProfileImageBanned,
        this.songTitle,
        this.songImage,
        this.songLink,
        this.singerName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    caption = json['caption'];
    videoUrl = json['videoUrl'];
    videoImage = json['videoImage'];
    songId = json['songId'];
    shareCount = json['shareCount'];
    isFake = json['isFake'];
    createdAt = json['createdAt'];
    hashTag = json['hashTag'].cast<String>();
    userId = json['userId'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    isVerified = json['isVerified'];
    isLike = json['isLike'];
    isFollow = json['isFollow'];
    totalLikes = json['totalLikes'];
    totalComments = json['totalComments'];
    time = json['time'];
    isProfileImageBanned = json['isProfileImageBanned'];
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
    data['shareCount'] = this.shareCount;
    data['isFake'] = this.isFake;
    data['createdAt'] = this.createdAt;
    data['hashTag'] = this.hashTag;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['isVerified'] = this.isVerified;
    data['isLike'] = this.isLike;
    data['isFollow'] = this.isFollow;
    data['totalLikes'] = this.totalLikes;
    data['totalComments'] = this.totalComments;
    data['time'] = this.time;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['songTitle'] = this.songTitle;
    data['songImage'] = this.songImage;
    data['songLink'] = this.songLink;
    data['singerName'] = this.singerName;
    return data;
  }
}
