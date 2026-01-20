import 'dart:convert';

FetchUserCoinModel fetchUserCoinModelFromJson(String str) => FetchUserCoinModel.fromJson(json.decode(str));
String fetchUserCoinModelToJson(FetchUserCoinModel data) => json.encode(data.toJson());

class FetchUserCoinModel {
  FetchUserCoinModel({
    bool? status,
    String? message,
    int? userCoin,
  }) {
    _status = status;
    _message = message;
    _userCoin = userCoin;
  }

  FetchUserCoinModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userCoin = json['userCoin'];
  }
  bool? _status;
  String? _message;
  int? _userCoin;
  FetchUserCoinModel copyWith({
    bool? status,
    String? message,
    int? userCoin,
  }) =>
      FetchUserCoinModel(
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
