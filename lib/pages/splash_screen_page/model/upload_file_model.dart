import 'dart:convert';

UploadFileModel uploadProfileImageModelFromJson(String str) => UploadFileModel.fromJson(json.decode(str));
String uploadProfileImageModelToJson(UploadFileModel data) => json.encode(data.toJson());

class UploadFileModel {
  UploadFileModel({
    bool? status,
    String? message,
    String? url,
  }) {
    _status = status;
    _message = message;
    _url = url;
  }

  UploadFileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _url = json['url'];
  }
  bool? _status;
  String? _message;
  String? _url;
  UploadFileModel copyWith({
    bool? status,
    String? message,
    String? url,
  }) =>
      UploadFileModel(
        status: status ?? _status,
        message: message ?? _message,
        url: url ?? _url,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['url'] = _url;
    return map;
  }
}
