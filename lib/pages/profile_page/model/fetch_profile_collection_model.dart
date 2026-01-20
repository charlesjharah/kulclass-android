import 'dart:convert';

FetchProfileCollectionModel fetchProfileCollectionModelFromJson(String str) =>
    FetchProfileCollectionModel.fromJson(json.decode(str));
String fetchProfileCollectionModelToJson(FetchProfileCollectionModel data) => json.encode(data.toJson());

class FetchProfileCollectionModel {
  FetchProfileCollectionModel({
    bool? status,
    String? message,
    List<ProfileCollectionData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchProfileCollectionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProfileCollectionData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ProfileCollectionData>? _data;
  FetchProfileCollectionModel copyWith({
    bool? status,
    String? message,
    List<ProfileCollectionData>? data,
  }) =>
      FetchProfileCollectionModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ProfileCollectionData>? get data => _data;

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

ProfileCollectionData dataFromJson(String str) => ProfileCollectionData.fromJson(json.decode(str));
String dataToJson(ProfileCollectionData data) => json.encode(data.toJson());

class ProfileCollectionData {
  ProfileCollectionData({
    int? total,
    int? giftCoin,
    String? giftImage,
    int? giftType,
  }) {
    _total = total;
    _giftCoin = giftCoin;
    _giftImage = giftImage;
    _giftType = giftType;
  }

  ProfileCollectionData.fromJson(dynamic json) {
    _total = json['total'];
    _giftCoin = json['giftCoin'];
    _giftImage = json['giftImage'];
    _giftType = json['giftType'];
  }
  int? _total;
  int? _giftCoin;
  String? _giftImage;
  int? _giftType;
  ProfileCollectionData copyWith({
    int? total,
    int? giftCoin,
    String? giftImage,
    int? giftType,
  }) =>
      ProfileCollectionData(
        total: total ?? _total,
        giftCoin: giftCoin ?? _giftCoin,
        giftImage: giftImage ?? _giftImage,
        giftType: giftType ?? _giftType,
      );
  int? get total => _total;
  int? get giftCoin => _giftCoin;
  String? get giftImage => _giftImage;
  int? get giftType => _giftType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['giftCoin'] = _giftCoin;
    map['giftImage'] = _giftImage;
    map['giftType'] = _giftType;
    return map;
  }
}
