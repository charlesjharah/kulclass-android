import 'dart:convert';

FetchBannerModel fetchBannerModelFromJson(String str) => FetchBannerModel.fromJson(json.decode(str));
String fetchBannerModelToJson(FetchBannerModel data) => json.encode(data.toJson());

class FetchBannerModel {
  FetchBannerModel({
    bool? status,
    String? message,
    List<BannerData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<BannerData>? _data;
  FetchBannerModel copyWith({
    bool? status,
    String? message,
    List<BannerData>? data,
  }) =>
      FetchBannerModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<BannerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

BannerData dataFromJson(String str) => BannerData.fromJson(json.decode(str));
String dataToJson(BannerData data) => json.encode(data.toJson());

class BannerData {
  BannerData({
    String? id,
    String? image,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _image = image;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BannerData.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _isActive = json['isActive'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _image;
  bool? _isActive;
  String? _createdAt;
  String? _updatedAt;
  BannerData copyWith({
    String? id,
    String? image,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      BannerData(
        id: id ?? _id,
        image: image ?? _image,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get image => _image;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['isActive'] = _isActive;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
