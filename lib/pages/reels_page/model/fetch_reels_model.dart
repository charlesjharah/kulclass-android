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
  // ADDED THIS FIELD
  String? userEmail; 
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
      // ADDED TO CONSTRUCTOR
      this.userEmail,
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
    // Handle null hashtag list safely
    if (json['hashTag'] != null) {
      hashTag = json['hashTag'].cast<String>();
    }
    userId = json['userId'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    // MAPPING THE NEW FIELD
    // Ensure your API sends 'userEmail' key, or change this string to match your API
    userEmail = json['userEmail']; 
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['caption'] = caption;
    data['videoUrl'] = videoUrl;
    data['videoImage'] = videoImage;
    data['songId'] = songId;
    data['shareCount'] = shareCount;
    data['isFake'] = isFake;
    data['createdAt'] = createdAt;
    data['hashTag'] = hashTag;
    data['userId'] = userId;
    data['name'] = name;
    data['userName'] = userName;
    data['userImage'] = userImage;
    // ADDED TO JSON OUTPUT
    data['userEmail'] = userEmail;
    data['isVerified'] = isVerified;
    data['isLike'] = isLike;
    data['isFollow'] = isFollow;
    data['totalLikes'] = totalLikes;
    data['totalComments'] = totalComments;
    data['time'] = time;
    data['isProfileImageBanned'] = isProfileImageBanned;
    data['songTitle'] = songTitle;
    data['songImage'] = songImage;
    data['songLink'] = songLink;
    data['singerName'] = singerName;
    return data;
  }
}