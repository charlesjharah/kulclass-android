import 'dart:convert';

UploadPostModel uploadPostModelFromJson(String str) => UploadPostModel.fromJson(json.decode(str));
String uploadPostModelToJson(UploadPostModel data) => json.encode(data.toJson());

class UploadPostModel {
  UploadPostModel({
    bool? status,
    String? message,
    Post? post,
  }) {
    _status = status;
    _message = message;
    _post = post;
  }

  UploadPostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }
  bool? _status;
  String? _message;
  Post? _post;
  UploadPostModel copyWith({
    bool? status,
    String? message,
    Post? post,
  }) =>
      UploadPostModel(
        status: status ?? _status,
        message: message ?? _message,
        post: post ?? _post,
      );
  bool? get status => _status;
  String? get message => _message;
  Post? get post => _post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_post != null) {
      map['post'] = _post?.toJson();
    }
    return map;
  }
}

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    LocationCoordinates? locationCoordinates,
    String? uniquePostId,
    String? caption,
    String? mainPostImage,
    List<String>? postImage,
    String? location,
    List<String>? hashTagId,
    String? userId,
    int? shareCount,
    bool? isFake,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _locationCoordinates = locationCoordinates;
    _uniquePostId = uniquePostId;
    _caption = caption;
    _mainPostImage = mainPostImage;
    _postImage = postImage;
    _location = location;
    _hashTagId = hashTagId;
    _userId = userId;
    _shareCount = shareCount;
    _isFake = isFake;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Post.fromJson(dynamic json) {
    _locationCoordinates =
        json['locationCoordinates'] != null ? LocationCoordinates.fromJson(json['locationCoordinates']) : null;
    _uniquePostId = json['uniquePostId'];
    _caption = json['caption'];
    _mainPostImage = json['mainPostImage'];
    _postImage = json['postImage'] != null ? json['postImage'].cast<String>() : [];
    _location = json['location'];
    _hashTagId = json['hashTagId'] != null ? json['hashTagId'].cast<String>() : [];
    _userId = json['userId'];
    _shareCount = json['shareCount'];
    _isFake = json['isFake'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  LocationCoordinates? _locationCoordinates;
  String? _uniquePostId;
  String? _caption;
  String? _mainPostImage;
  List<String>? _postImage;
  String? _location;
  List<String>? _hashTagId;
  String? _userId;
  int? _shareCount;
  bool? _isFake;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  Post copyWith({
    LocationCoordinates? locationCoordinates,
    String? uniquePostId,
    String? caption,
    String? mainPostImage,
    List<String>? postImage,
    String? location,
    List<String>? hashTagId,
    String? userId,
    int? shareCount,
    bool? isFake,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) =>
      Post(
        locationCoordinates: locationCoordinates ?? _locationCoordinates,
        uniquePostId: uniquePostId ?? _uniquePostId,
        caption: caption ?? _caption,
        mainPostImage: mainPostImage ?? _mainPostImage,
        postImage: postImage ?? _postImage,
        location: location ?? _location,
        hashTagId: hashTagId ?? _hashTagId,
        userId: userId ?? _userId,
        shareCount: shareCount ?? _shareCount,
        isFake: isFake ?? _isFake,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  LocationCoordinates? get locationCoordinates => _locationCoordinates;
  String? get uniquePostId => _uniquePostId;
  String? get caption => _caption;
  String? get mainPostImage => _mainPostImage;
  List<String>? get postImage => _postImage;
  String? get location => _location;
  List<String>? get hashTagId => _hashTagId;
  String? get userId => _userId;
  int? get shareCount => _shareCount;
  bool? get isFake => _isFake;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_locationCoordinates != null) {
      map['locationCoordinates'] = _locationCoordinates?.toJson();
    }
    map['uniquePostId'] = _uniquePostId;
    map['caption'] = _caption;
    map['mainPostImage'] = _mainPostImage;
    map['postImage'] = _postImage;
    map['location'] = _location;
    map['hashTagId'] = _hashTagId;
    map['userId'] = _userId;
    map['shareCount'] = _shareCount;
    map['isFake'] = _isFake;
    map['_id'] = _id;
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
