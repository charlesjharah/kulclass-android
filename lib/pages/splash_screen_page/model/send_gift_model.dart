import 'dart:convert';

SendGiftModel sendGiftModelFromJson(String str) => SendGiftModel.fromJson(json.decode(str));
String sendGiftModelToJson(SendGiftModel data) => json.encode(data.toJson());

class SendGiftModel {
  SendGiftModel({
    bool? status,
    String? message,
    int? userCoin,
  }) {
    _status = status;
    _message = message;
    _userCoin = userCoin;
  }

  SendGiftModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userCoin = json['userCoin'];
  }
  bool? _status;
  String? _message;
  int? _userCoin;
  SendGiftModel copyWith({
    bool? status,
    String? message,
    int? userCoin,
  }) =>
      SendGiftModel(
        status: status ?? _status,
        message: message ?? _message,
        userCoin: userCoin ?? _userCoin,
      );
  bool? get status => _status;
  String? get message => _message;
  int? get userCoin => _userCoin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['userCoin'] = _userCoin;
    return map;
  }
}
