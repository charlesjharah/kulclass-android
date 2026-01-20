import 'dart:convert';

DeleteReelsModel deleteReelsModelFromJson(String str) => DeleteReelsModel.fromJson(json.decode(str));
String deleteReelsModelToJson(DeleteReelsModel data) => json.encode(data.toJson());

class DeleteReelsModel {
  DeleteReelsModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  DeleteReelsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  DeleteReelsModel copyWith({
    bool? status,
    String? message,
  }) =>
      DeleteReelsModel(
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
