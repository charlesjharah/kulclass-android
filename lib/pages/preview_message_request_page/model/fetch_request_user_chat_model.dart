class FetchRequestUserChatModel {
  bool? status;
  String? message;
  String? chatTopic;
  List<Chat>? chat;

  FetchRequestUserChatModel({this.status, this.message, this.chatTopic, this.chat});

  FetchRequestUserChatModel.fromJson(Map<String, dynamic> json) {
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
  String? chatRequestTopicId;
  String? message;
  String? audio;
  String? image;
  bool? isChatMediaBanned;
  bool? isRead;
  String? date;
  String? senderUserId;
  int? messageType;
  String? createdAt;
  String? updatedAt;

  Chat(
      {this.id,
      this.chatRequestTopicId,
      this.message,
      this.audio,
      this.image,
      this.isChatMediaBanned,
      this.isRead,
      this.date,
      this.senderUserId,
      this.messageType,
      this.createdAt,
      this.updatedAt});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    chatRequestTopicId = json['chatRequestTopicId'];
    message = json['message'];
    audio = json['audio'];
    image = json['image'];
    isChatMediaBanned = json['isChatMediaBanned'];
    isRead = json['isRead'];
    date = json['date'];
    senderUserId = json['senderUserId'];
    messageType = json['messageType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['chatRequestTopicId'] = this.chatRequestTopicId;
    data['message'] = this.message;
    data['audio'] = this.audio;
    data['image'] = this.image;
    data['isChatMediaBanned'] = this.isChatMediaBanned;
    data['isRead'] = this.isRead;
    data['date'] = this.date;
    data['senderUserId'] = this.senderUserId;
    data['messageType'] = this.messageType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
