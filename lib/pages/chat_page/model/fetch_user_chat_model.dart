class FetchUserChatModel {
  bool? status;
  String? message;
  String? chatTopic;
  List<Chat>? chat;

  FetchUserChatModel({this.status, this.message, this.chatTopic, this.chat});

  FetchUserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    chatTopic = json['chatTopic'];
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['chatTopic'] = this.chatTopic;
    if (this.chat != null) {
      data['chat'] = this.chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  String? id;
  String? chatTopicId;
  String? senderUserId;
  String? message;
  String? audio;
  String? image;
  bool? isChatMediaBanned;
  bool? isRead;
  String? date;
  int? messageType;
  String? createdAt;
  String? updatedAt;

  Chat(
      {this.id,
      this.chatTopicId,
      this.senderUserId,
      this.message,
      this.audio,
      this.image,
      this.isChatMediaBanned,
      this.isRead,
      this.date,
      this.messageType,
      this.createdAt,
      this.updatedAt});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    chatTopicId = json['chatTopicId'];
    senderUserId = json['senderUserId'];
    message = json['message'];
    audio = json['audio'];
    image = json['image'];
    isChatMediaBanned = json['isChatMediaBanned'];
    isRead = json['isRead'];
    date = json['date'];
    messageType = json['messageType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['chatTopicId'] = this.chatTopicId;
    data['senderUserId'] = this.senderUserId;
    data['message'] = this.message;
    data['audio'] = this.audio;
    data['image'] = this.image;
    data['isChatMediaBanned'] = this.isChatMediaBanned;
    data['isRead'] = this.isRead;
    data['date'] = this.date;
    data['messageType'] = this.messageType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
