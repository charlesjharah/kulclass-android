import 'dart:convert';

FetchWithdrawMethodModel fetchWithdrawMethodModelFromJson(String str) =>
    FetchWithdrawMethodModel.fromJson(json.decode(str));
String fetchWithdrawMethodModelToJson(FetchWithdrawMethodModel data) => json.encode(data.toJson());

class FetchWithdrawMethodModel {
  FetchWithdrawMethodModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchWithdrawMethodModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  FetchWithdrawMethodModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchWithdrawMethodModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? name,
    String? image,
    List<String>? details,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _details = details;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _image = json['image'];
    _details = json['details'] != null ? json['details'].cast<String>() : [];
    _isActive = json['isActive'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _image;
  List<String>? _details;
  bool? _isActive;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? details,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        details: details ?? _details,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  List<String>? get details => _details;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['details'] = _details;
    map['isActive'] = _isActive;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
