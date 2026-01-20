class CommentModel {
  bool? status;
  String? message;
  List<PostOrVideoComment>? postOrVideoComment;

  CommentModel({this.status, this.message, this.postOrVideoComment});

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['postOrVideoComment'] != null) {
      postOrVideoComment = <PostOrVideoComment>[];
      json['postOrVideoComment'].forEach((v) {
        postOrVideoComment!.add(new PostOrVideoComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.postOrVideoComment != null) {
      data['postOrVideoComment'] = this.postOrVideoComment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostOrVideoComment {
  String? id;
  String? commentText;
  String? createdAt;
  String? userId;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  String? userImage;
  int? totalLikes;
  bool? isLike;
  String? time;

  PostOrVideoComment(
      {this.id, this.commentText, this.createdAt, this.userId, this.isProfileImageBanned, this.name, this.userName, this.userImage, this.totalLikes, this.isLike, this.time});

  PostOrVideoComment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    commentText = json['commentText'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    userImage = json['userImage'];
    totalLikes = json['totalLikes'];
    isLike = json['isLike'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['totalLikes'] = this.totalLikes;
    data['isLike'] = this.isLike;
    data['time'] = this.time;
    return data;
  }
}
