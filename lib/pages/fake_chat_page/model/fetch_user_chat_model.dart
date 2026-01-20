import 'dart:convert';
FetchUserChatModel fetchUserChatModelFromJson(String str) => FetchUserChatModel.fromJson(json.decode(str));
String fetchUserChatModelToJson(FetchUserChatModel data) => json.encode(data.toJson());
class FetchUserChatModel {
  FetchUserChatModel({
      bool? status, 
      String? message, 
      String? chatTopic, 
      List<Chat>? chat,}){
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
    _chat = chat;
}

  FetchUserChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'];
    if (json['chat'] != null) {
      _chat = [];
      json['chat'].forEach((v) {
        _chat?.add(Chat.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _chatTopic;
  List<Chat>? _chat;
FetchUserChatModel copyWith({  bool? status,
  String? message,
  String? chatTopic,
  List<Chat>? chat,
}) => FetchUserChatModel(  status: status ?? _status,
  message: message ?? _message,
  chatTopic: chatTopic ?? _chatTopic,
  chat: chat ?? _chat,
);
  bool? get status => _status;
  String? get message => _message;
  String? get chatTopic => _chatTopic;
  List<Chat>? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['chatTopic'] = _chatTopic;
    if (_chat != null) {
      map['chat'] = _chat?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data) => json.encode(data.toJson());
class Chat {
  Chat({
      String? id, 
      String? chatTopicId, 
      String? senderUserId, 
      String? message, 
      dynamic image, 
      String? audio, 
      bool? isRead, 
      String? date, 
      int? messageType, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _chatTopicId = chatTopicId;
    _senderUserId = senderUserId;
    _message = message;
    _image = image;
    _audio = audio;
    _isRead = isRead;
    _date = date;
    _messageType = messageType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Chat.fromJson(dynamic json) {
    _id = json['_id'];
    _chatTopicId = json['chatTopicId'];
    _senderUserId = json['senderUserId'];
    _message = json['message'];
    _image = json['image'];
    _audio = json['audio'];
    _isRead = json['isRead'];
    _date = json['date'];
    _messageType = json['messageType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _chatTopicId;
  String? _senderUserId;
  String? _message;
  dynamic _image;
  String? _audio;
  bool? _isRead;
  String? _date;
  int? _messageType;
  String? _createdAt;
  String? _updatedAt;
Chat copyWith({  String? id,
  String? chatTopicId,
  String? senderUserId,
  String? message,
  dynamic image,
  String? audio,
  bool? isRead,
  String? date,
  int? messageType,
  String? createdAt,
  String? updatedAt,
}) => Chat(  id: id ?? _id,
  chatTopicId: chatTopicId ?? _chatTopicId,
  senderUserId: senderUserId ?? _senderUserId,
  message: message ?? _message,
  image: image ?? _image,
  audio: audio ?? _audio,
  isRead: isRead ?? _isRead,
  date: date ?? _date,
  messageType: messageType ?? _messageType,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get chatTopicId => _chatTopicId;
  String? get senderUserId => _senderUserId;
  String? get message => _message;
  dynamic get image => _image;
  String? get audio => _audio;
  bool? get isRead => _isRead;
  String? get date => _date;
  int? get messageType => _messageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['chatTopicId'] = _chatTopicId;
    map['senderUserId'] = _senderUserId;
    map['message'] = _message;
    map['image'] = _image;
    map['audio'] = _audio;
    map['isRead'] = _isRead;
    map['date'] = _date;
    map['messageType'] = _messageType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}