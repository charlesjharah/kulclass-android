import 'dart:convert';

FetchHashTagModel fetchHashTagModelFromJson(String str) => FetchHashTagModel.fromJson(json.decode(str));
String fetchHashTagModelToJson(FetchHashTagModel data) => json.encode(data.toJson());

class FetchHashTagModel {
  FetchHashTagModel({
    bool? status,
    String? message,
    List<HashTagData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchHashTagModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HashTagData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<HashTagData>? _data;
  FetchHashTagModel copyWith({
    bool? status,
    String? message,
    List<HashTagData>? data,
  }) =>
      FetchHashTagModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<HashTagData>? get data => _data;

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

HashTagData dataFromJson(String str) => HashTagData.fromJson(json.decode(str));
String dataToJson(HashTagData data) => json.encode(data.toJson());

class HashTagData {
  HashTagData({
    String? id,
    String? hashTag,
    int? totalHashTagUsedCount,
  }) {
    _id = id;
    _hashTag = hashTag;
    _totalHashTagUsedCount = totalHashTagUsedCount;
  }

  HashTagData.fromJson(dynamic json) {
    _id = json['_id'];
    _hashTag = json['hashTag'];
    _totalHashTagUsedCount = json['totalHashTagUsedCount'];
  }
  String? _id;
  String? _hashTag;
  int? _totalHashTagUsedCount;
  HashTagData copyWith({
    String? id,
    String? hashTag,
    int? totalHashTagUsedCount,
  }) =>
      HashTagData(
        id: id ?? _id,
        hashTag: hashTag ?? _hashTag,
        totalHashTagUsedCount: totalHashTagUsedCount ?? _totalHashTagUsedCount,
      );
  String? get id => _id;
  String? get hashTag => _hashTag;
  int? get totalHashTagUsedCount => _totalHashTagUsedCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hashTag'] = _hashTag;
    map['totalHashTagUsedCount'] = _totalHashTagUsedCount;
    return map;
  }
}
