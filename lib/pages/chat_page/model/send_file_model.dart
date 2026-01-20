class SendFileModel {
  bool? status;
  String? message;
  SendFileData? chat;

  SendFileModel({this.status, this.message, this.chat});

  SendFileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    chat = json['chat'] != null ? new SendFileData.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    return data;
  }
}

class SendFileData {
  String? chatRequestTopicId;
  String? message;
  String? audio;
  String? image;
  bool? isChatMediaBanned;
  bool? isRead;
  String? date;
  String? id;
  String? senderUserId;
  int? messageType;
  String? createdAt;
  String? updatedAt;

  SendFileData(
      {this.chatRequestTopicId,
      this.message,
      this.audio,
      this.image,
      this.isChatMediaBanned,
      this.isRead,
      this.date,
      this.id,
      this.senderUserId,
      this.messageType,
      this.createdAt,
      this.updatedAt});

  SendFileData.fromJson(Map<String, dynamic> json) {
    chatRequestTopicId = json['chatRequestTopicId'];
    message = json['message'];
    audio = json['audio'];
    image = json['image'];
    isChatMediaBanned = json['isChatMediaBanned'];
    isRead = json['isRead'];
    date = json['date'];
    id = json['_id'];
    senderUserId = json['senderUserId'];
    messageType = json['messageType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatRequestTopicId'] = this.chatRequestTopicId;
    data['message'] = this.message;
    data['audio'] = this.audio;
    data['image'] = this.image;
    data['isChatMediaBanned'] = this.isChatMediaBanned;
    data['isRead'] = this.isRead;
    data['date'] = this.date;
    data['_id'] = this.id;
    data['senderUserId'] = this.senderUserId;
    data['messageType'] = this.messageType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
