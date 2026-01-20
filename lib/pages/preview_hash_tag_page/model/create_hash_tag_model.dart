import 'dart:convert';

CreateHashTagModel createHashTagModelFromJson(String str) => CreateHashTagModel.fromJson(json.decode(str));
String createHashTagModelToJson(CreateHashTagModel data) => json.encode(data.toJson());

class CreateHashTagModel {
  CreateHashTagModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CreateHashTagModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  CreateHashTagModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      CreateHashTagModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? hashTag,
    String? hashTagIcon,
    String? hashTagBanner,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _hashTag = hashTag;
    _hashTagIcon = hashTagIcon;
    _hashTagBanner = hashTagBanner;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _hashTag = json['hashTag'];
    _hashTagIcon = json['hashTagIcon'];
    _hashTagBanner = json['hashTagBanner'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _hashTag;
  String? _hashTagIcon;
  String? _hashTagBanner;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? hashTag,
    String? hashTagIcon,
    String? hashTagBanner,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        hashTag: hashTag ?? _hashTag,
        hashTagIcon: hashTagIcon ?? _hashTagIcon,
        hashTagBanner: hashTagBanner ?? _hashTagBanner,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get hashTag => _hashTag;
  String? get hashTagIcon => _hashTagIcon;
  String? get hashTagBanner => _hashTagBanner;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hashTag'] = _hashTag;
    map['hashTagIcon'] = _hashTagIcon;
    map['hashTagBanner'] = _hashTagBanner;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
