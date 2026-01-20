import 'package:auralive/pages/feed_page/model/post_image_model.dart';

class EditPostModel {
  bool? status;
  String? message;
  Data? data;

  EditPostModel({this.status, this.message, this.data});

  EditPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? uniquePostId;
  String? caption;
  String? mainPostImage;
  String? location;
  List<String>? hashTagId;
  String? userId;
  int? shareCount;
  bool? isFake;
  List<PostImage>? postImage;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.uniquePostId,
      this.caption,
      this.mainPostImage,
      this.location,
      this.hashTagId,
      this.userId,
      this.shareCount,
      this.isFake,
      this.postImage,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uniquePostId = json['uniquePostId'];
    caption = json['caption'];
    mainPostImage = json['mainPostImage'];
    location = json['location'];
    hashTagId = json['hashTagId'].cast<String>();
    userId = json['userId'];
    shareCount = json['shareCount'];
    isFake = json['isFake'];
    if (json['postImage'] != null) {
      postImage = <PostImage>[];
      json['postImage'].forEach((v) {
        postImage!.add(new PostImage.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uniquePostId'] = this.uniquePostId;
    data['caption'] = this.caption;
    data['mainPostImage'] = this.mainPostImage;
    data['location'] = this.location;
    data['hashTagId'] = this.hashTagId;
    data['userId'] = this.userId;
    data['shareCount'] = this.shareCount;
    data['isFake'] = this.isFake;
    if (this.postImage != null) {
      data['postImage'] = this.postImage!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
