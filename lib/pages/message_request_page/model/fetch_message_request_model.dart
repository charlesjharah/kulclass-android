class FetchMessageRequestModel {
  bool? status;
  String? message;
  List<Data>? data;

  FetchMessageRequestModel({this.status, this.message, this.data});

  FetchMessageRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  String? image;
  bool? isOnline;
  bool? isVerified;
  bool? isFake;
  String? userId;
  String? chatRequestTopicId;
  String? senderUserId;
  String? message;
  int? unreadCount;
  String? time;

  Data(
      {this.sId,
      this.isProfileImageBanned,
      this.name,
      this.userName,
      this.image,
      this.isOnline,
      this.isVerified,
      this.isFake,
      this.userId,
      this.chatRequestTopicId,
      this.senderUserId,
      this.message,
      this.unreadCount,
      this.time});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isOnline = json['isOnline'];
    isVerified = json['isVerified'];
    isFake = json['isFake'];
    userId = json['userId'];
    chatRequestTopicId = json['chatRequestTopicId'];
    senderUserId = json['senderUserId'];
    message = json['message'];
    unreadCount = json['unreadCount'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['isOnline'] = this.isOnline;
    data['isVerified'] = this.isVerified;
    data['isFake'] = this.isFake;
    data['userId'] = this.userId;
    data['chatRequestTopicId'] = this.chatRequestTopicId;
    data['senderUserId'] = this.senderUserId;
    data['message'] = this.message;
    data['unreadCount'] = this.unreadCount;
    data['time'] = this.time;
    return data;
  }
}
