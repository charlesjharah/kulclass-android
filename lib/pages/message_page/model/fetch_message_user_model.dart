class FetchMessageUserModel {
  bool? status;
  String? message;
  int? pendingCount;
  List<Data>? data;

  FetchMessageUserModel({this.status, this.message, this.pendingCount, this.data});

  FetchMessageUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pendingCount = json['pendingCount'];
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
    data['pendingCount'] = this.pendingCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? userName;
  String? image;
  bool? isOnline;
  bool? isVerified;
  bool? isFake;
  String? userId;
  String? chatTopicId;
  String? senderUserId;
  String? message;
  int? unreadCount;
  bool? isAccepted;
  String? time;
  bool? isProfileImageBanned;

  Data(
      {this.id,
      this.name,
      this.userName,
      this.image,
      this.isOnline,
      this.isVerified,
      this.isFake,
      this.userId,
      this.chatTopicId,
      this.senderUserId,
      this.message,
      this.unreadCount,
      this.isAccepted,
      this.time,
      this.isProfileImageBanned});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isOnline = json['isOnline'];
    isVerified = json['isVerified'];
    isFake = json['isFake'];
    userId = json['userId'];
    chatTopicId = json['chatTopicId'];
    senderUserId = json['senderUserId'];
    message = json['message'];
    unreadCount = json['unreadCount'];
    isAccepted = json['isAccepted'];
    time = json['time'];
    isProfileImageBanned = json['isProfileImageBanned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['isOnline'] = this.isOnline;
    data['isVerified'] = this.isVerified;
    data['isFake'] = this.isFake;
    data['userId'] = this.userId;
    data['chatTopicId'] = this.chatTopicId;
    data['senderUserId'] = this.senderUserId;
    data['message'] = this.message;
    data['unreadCount'] = this.unreadCount;
    data['isAccepted'] = this.isAccepted;
    data['time'] = this.time;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    return data;
  }
}
