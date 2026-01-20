import 'package:auralive/pages/feed_page/model/post_image_model.dart';

class FetchHashTagPostModel {
  bool? status;
  String? message;
  List<PostData>? data;

  FetchHashTagPostModel({this.status, this.message, this.data});

  FetchHashTagPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(new PostData.fromJson(v));
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

class PostData {
  String? id;
  bool? isLike;
  int? totalLikes;
  int? totalComments;
  String? postId;
  String? caption;
  String? mainPostImage;
  List<PostImage>? postImage;
  String? createdAt;
  String? userId;
  String? name;
  String? userName;
  String? userImage;
  bool? isVerified;
  bool? isProfileImageBanned;
  bool? isFake;
  List<String>? hashTag;
  String? time;

  PostData(
      {this.id,
      this.isLike,
      this.totalLikes,
      this.totalComments,
      this.postId,
      this.caption,
      this.mainPostImage,
      this.postImage,
      this.createdAt,
      this.userId,
      this.name,
      this.userName,
      this.userImage,
      this.isVerified,
      this.isProfileImageBanned,
      this.isFake,
      this.hashTag,
      this.time});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isLike = json['isLike'];
    totalLikes = json['totalLikes'];
    totalComments = json['totalComments'];
    postId = json['postId'];
    caption = json['caption'];
    mainPostImage = json['mainPostImage'];
    if (json['postImage'] != null) {
      postImage = <PostImage>[];
      json['postImage'].forEach((v) {
        postImage!.add(new PostImage.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    userId = json['userId'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    isVerified = json['isVerified'];
    isProfileImageBanned = json['isProfileImageBanned'];
    isFake = json['isFake'];
    hashTag = json['hashTag'].cast<String>();
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['isLike'] = this.isLike;
    data['totalLikes'] = this.totalLikes;
    data['totalComments'] = this.totalComments;
    data['postId'] = this.postId;
    data['caption'] = this.caption;
    data['mainPostImage'] = this.mainPostImage;
    if (this.postImage != null) {
      data['postImage'] = this.postImage!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['isVerified'] = this.isVerified;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['isFake'] = this.isFake;
    data['hashTag'] = this.hashTag;
    data['time'] = this.time;
    return data;
  }
}
