import 'dart:convert';

DeleteUserModel deleteUserModelFromJson(String str) => DeleteUserModel.fromJson(json.decode(str));
String deleteUserModelToJson(DeleteUserModel data) => json.encode(data.toJson());

class DeleteUserModel {
  DeleteUserModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  DeleteUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  DeleteUserModel copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteUserModel(
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
