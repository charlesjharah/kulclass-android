import 'dart:convert';

UploadReelsModel uploadReelsModelFromJson(String str) => UploadReelsModel.fromJson(json.decode(str));
String uploadReelsModelToJson(UploadReelsModel data) => json.encode(data.toJson());

class UploadReelsModel {
  UploadReelsModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  UploadReelsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  UploadReelsModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      UploadReelsModel(
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
    LocationCoordinates? locationCoordinates,
    String? uniqueVideoId,
    String? caption,
    String? videoUrl,
    String? videoImage,
    String? location,
    List<String>? hashTagId,
    dynamic songId,
    String? userId,
    int? shareCount,
    bool? isFake,
    String? id,
    int? videoTime,
    String? createdAt,
    String? updatedAt,
  }) {
    _locationCoordinates = locationCoordinates;
    _uniqueVideoId = uniqueVideoId;
    _caption = caption;
    _videoUrl = videoUrl;
    _videoImage = videoImage;
    _location = location;
    _hashTagId = hashTagId;
    _songId = songId;
    _userId = userId;
    _shareCount = shareCount;
    _isFake = isFake;
    _id = id;
    _videoTime = videoTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _locationCoordinates =
        json['locationCoordinates'] != null ? LocationCoordinates.fromJson(json['locationCoordinates']) : null;
    _uniqueVideoId = json['uniqueVideoId'];
    _caption = json['caption'];
    _videoUrl = json['videoUrl'];
    _videoImage = json['videoImage'];
    _location = json['location'];
    _hashTagId = json['hashTagId'] != null ? json['hashTagId'].cast<String>() : [];
    _songId = json['songId'];
    _userId = json['userId'];
    _shareCount = json['shareCount'];
    _isFake = json['isFake'];
    _id = json['_id'];
    _videoTime = json['videoTime'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  LocationCoordinates? _locationCoordinates;
  String? _uniqueVideoId;
  String? _caption;
  String? _videoUrl;
  String? _videoImage;
  String? _location;
  List<String>? _hashTagId;
  dynamic _songId;
  String? _userId;
  int? _shareCount;
  bool? _isFake;
  String? _id;
  int? _videoTime;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    LocationCoordinates? locationCoordinates,
    String? uniqueVideoId,
    String? caption,
    String? videoUrl,
    String? videoImage,
    String? location,
    List<String>? hashTagId,
    dynamic songId,
    String? userId,
    int? shareCount,
    bool? isFake,
    String? id,
    int? videoTime,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        locationCoordinates: locationCoordinates ?? _locationCoordinates,
        uniqueVideoId: uniqueVideoId ?? _uniqueVideoId,
        caption: caption ?? _caption,
        videoUrl: videoUrl ?? _videoUrl,
        videoImage: videoImage ?? _videoImage,
        location: location ?? _location,
        hashTagId: hashTagId ?? _hashTagId,
        songId: songId ?? _songId,
        userId: userId ?? _userId,
        shareCount: shareCount ?? _shareCount,
        isFake: isFake ?? _isFake,
        id: id ?? _id,
        videoTime: videoTime ?? _videoTime,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  LocationCoordinates? get locationCoordinates => _locationCoordinates;
  String? get uniqueVideoId => _uniqueVideoId;
  String? get caption => _caption;
  String? get videoUrl => _videoUrl;
  String? get videoImage => _videoImage;
  String? get location => _location;
  List<String>? get hashTagId => _hashTagId;
  dynamic get songId => _songId;
  String? get userId => _userId;
  int? get shareCount => _shareCount;
  bool? get isFake => _isFake;
  String? get id => _id;
  int? get videoTime => _videoTime;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_locationCoordinates != null) {
      map['locationCoordinates'] = _locationCoordinates?.toJson();
    }
    map['uniqueVideoId'] = _uniqueVideoId;
    map['caption'] = _caption;
    map['videoUrl'] = _videoUrl;
    map['videoImage'] = _videoImage;
    map['location'] = _location;
    map['hashTagId'] = _hashTagId;
    map['songId'] = _songId;
    map['userId'] = _userId;
    map['shareCount'] = _shareCount;
    map['isFake'] = _isFake;
    map['_id'] = _id;
    map['videoTime'] = _videoTime;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

LocationCoordinates locationCoordinatesFromJson(String str) => LocationCoordinates.fromJson(json.decode(str));
String locationCoordinatesToJson(LocationCoordinates data) => json.encode(data.toJson());

class LocationCoordinates {
  LocationCoordinates({
    String? latitude,
    String? longitude,
  }) {
    _latitude = latitude;
    _longitude = longitude;
  }

  LocationCoordinates.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  String? _latitude;
  String? _longitude;
  LocationCoordinates copyWith({
    String? latitude,
    String? longitude,
  }) =>
      LocationCoordinates(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
