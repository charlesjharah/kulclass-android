import 'dart:convert';

CreateLiveUserModel createLiveUserModelFromJson(String str) => CreateLiveUserModel.fromJson(json.decode(str));
String createLiveUserModelToJson(CreateLiveUserModel data) => json.encode(data.toJson());

class CreateLiveUserModel {
  CreateLiveUserModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CreateLiveUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  CreateLiveUserModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      CreateLiveUserModel(
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
    String? name,
    String? userName,
    String? image,
    int? view,
    String? id,
    String? liveHistoryId,
    String? userId,
    String? createdAt,
    String? updatedAt,
  }) {
    _name = name;
    _userName = userName;
    _image = image;
    _view = view;
    _id = id;
    _liveHistoryId = liveHistoryId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _view = json['view'];
    _id = json['_id'];
    _liveHistoryId = json['liveHistoryId'];
    _userId = json['userId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _name;
  String? _userName;
  String? _image;
  int? _view;
  String? _id;
  String? _liveHistoryId;
  String? _userId;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? name,
    String? userName,
    String? image,
    int? view,
    String? id,
    String? liveHistoryId,
    String? userId,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        view: view ?? _view,
        id: id ?? _id,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
        userId: userId ?? _userId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  int? get view => _view;
  String? get id => _id;
  String? get liveHistoryId => _liveHistoryId;
  String? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['view'] = _view;
    map['_id'] = _id;
    map['liveHistoryId'] = _liveHistoryId;
    map['userId'] = _userId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
