import 'dart:convert';

DeleteAllMessageRequestModel deleteAllMessageRequestModelFromJson(String str) => DeleteAllMessageRequestModel.fromJson(json.decode(str));
String deleteAllMessageRequestModelToJson(DeleteAllMessageRequestModel data) => json.encode(data.toJson());

class DeleteAllMessageRequestModel {
  DeleteAllMessageRequestModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  DeleteAllMessageRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  DeleteAllMessageRequestModel copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteAllMessageRequestModel(
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
