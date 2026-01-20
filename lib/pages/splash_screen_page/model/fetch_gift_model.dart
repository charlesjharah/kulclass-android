import 'dart:convert';

FetchGiftModel fetchGiftModelFromJson(String str) => FetchGiftModel.fromJson(json.decode(str));
String fetchGiftModelToJson(FetchGiftModel data) => json.encode(data.toJson());

class FetchGiftModel {
  FetchGiftModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchGiftModel.fromJson(dynamic json) {
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
  FetchGiftModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchGiftModel(
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
    int? type,
    String? image,
    String? svgaImage,
    int? coin,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _type = type;
    _image = image;
    _svgaImage = svgaImage;
    _coin = coin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _image = json['image'];
    _svgaImage = json['svgaImage'];
    _coin = json['coin'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  int? _type;
  String? _image;
  String? _svgaImage;
  int? _coin;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    String? id,
    int? type,
    String? image,
    String? svgaImage,
    int? coin,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
        svgaImage: svgaImage ?? _svgaImage,
        coin: coin ?? _coin,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  int? get type => _type;
  String? get image => _image;
  String? get svgaImage => _svgaImage;
  int? get coin => _coin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    map['svgaImage'] = _svgaImage;
    map['coin'] = _coin;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
