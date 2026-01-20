import 'package:auralive/pages/feed_page/model/post_image_model.dart';

class FetchPostModel {
  bool? status;
  String? message;
  List<Post>? post;

  FetchPostModel({this.status, this.message, this.post});

  FetchPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['post'] != null) {
      post = <Post>[];
      json['post'].forEach((v) {
        post!.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.post != null) {
      data['post'] = this.post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  String? id;
  String? caption;
  int? shareCount;
  bool? isFake;
  List<PostImage>? postImage;
  String? createdAt;
  String? userId;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  String? userImage;
  bool? isVerified;
  List<String>? hashTag;
  bool? isLike;
  bool? isFollow;
  int? totalLikes;
  int? totalComments;
  String? time;

  Post(
      {this.id,
      this.caption,
      this.shareCount,
      this.isFake,
      this.postImage,
      this.createdAt,
      this.userId,
      this.isProfileImageBanned,
      this.name,
      this.userName,
      this.userImage,
      this.isVerified,
      this.hashTag,
      this.isLike,
      this.isFollow,
      this.totalLikes,
      this.totalComments,
      this.time});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    caption = json['caption'];
    shareCount = json['shareCount'];
    isFake = json['isFake'];
    if (json['postImage'] != null) {
      postImage = <PostImage>[];
      json['postImage'].forEach((v) {
        postImage!.add(new PostImage.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    userId = json['userId'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    isVerified = json['isVerified'];
    hashTag = json['hashTag'].cast<String>();
    isLike = json['isLike'];
    isFollow = json['isFollow'];
    totalLikes = json['totalLikes'];
    totalComments = json['totalComments'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['caption'] = this.caption;
    data['shareCount'] = this.shareCount;
    data['isFake'] = this.isFake;
    if (this.postImage != null) {
      data['postImage'] = this.postImage!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['isVerified'] = this.isVerified;
    data['hashTag'] = this.hashTag;
    data['isLike'] = this.isLike;
    data['isFollow'] = this.isFollow;
    data['totalLikes'] = this.totalLikes;
    data['totalComments'] = this.totalComments;
    data['time'] = this.time;
    return data;
  }
}
