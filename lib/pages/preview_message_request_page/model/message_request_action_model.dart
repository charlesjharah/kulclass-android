import 'dart:convert';

MessageRequestActionModel messageRequestActionModelFromJson(String str) => MessageRequestActionModel.fromJson(json.decode(str));
String messageRequestActionModelToJson(MessageRequestActionModel data) => json.encode(data.toJson());

class MessageRequestActionModel {
  MessageRequestActionModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  MessageRequestActionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  MessageRequestActionModel copyWith({
    bool? status,
    String? message,
  }) =>
      MessageRequestActionModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
