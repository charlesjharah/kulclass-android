import 'package:auralive/pages/feed_page/model/post_image_model.dart';

class FetchProfilePostModel {
  bool? status;
  String? message;
  List<ProfilePostData>? data;

  FetchProfilePostModel({this.status, this.message, this.data});

  FetchProfilePostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProfilePostData>[];
      json['data'].forEach((v) {
        data!.add(new ProfilePostData.fromJson(v));
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

class ProfilePostData {
  String? id;
  String? caption;
  String? mainPostImage;
  List<PostImage>? postImage;

  ProfilePostData({this.id, this.caption, this.mainPostImage, this.postImage});

  ProfilePostData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    caption = json['caption'];
    mainPostImage = json['mainPostImage'];
    if (json['postImage'] != null) {
      postImage = <PostImage>[];
      json['postImage'].forEach((v) {
        postImage!.add(new PostImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['caption'] = this.caption;
    data['mainPostImage'] = this.mainPostImage;
    if (this.postImage != null) {
      data['postImage'] = this.postImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
