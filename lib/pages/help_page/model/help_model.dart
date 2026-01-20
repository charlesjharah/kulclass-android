import 'dart:convert';

HelpModel helpModelFromJson(String str) => HelpModel.fromJson(json.decode(str));
String helpModelToJson(HelpModel data) => json.encode(data.toJson());

class HelpModel {
  HelpModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  HelpModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  HelpModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      HelpModel(
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
    String? userId,
    String? complaint,
    String? contact,
    String? image,
    String? date,
    int? status,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _userId = userId;
    _complaint = complaint;
    _contact = contact;
    _image = image;
    _date = date;
    _status = status;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _complaint = json['complaint'];
    _contact = json['contact'];
    _image = json['image'];
    _date = json['date'];
    _status = json['status'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _userId;
  String? _complaint;
  String? _contact;
  String? _image;
  String? _date;
  int? _status;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? userId,
    String? complaint,
    String? contact,
    String? image,
    String? date,
    int? status,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        userId: userId ?? _userId,
        complaint: complaint ?? _complaint,
        contact: contact ?? _contact,
        image: image ?? _image,
        date: date ?? _date,
        status: status ?? _status,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get userId => _userId;
  String? get complaint => _complaint;
  String? get contact => _contact;
  String? get image => _image;
  String? get date => _date;
  int? get status => _status;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['complaint'] = _complaint;
    map['contact'] = _contact;
    map['image'] = _image;
    map['date'] = _date;
    map['status'] = _status;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
