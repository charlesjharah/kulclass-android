import 'dart:convert';

FetchFavoriteSoundModel fetchFavoriteSoundModelFromJson(String str) =>
    FetchFavoriteSoundModel.fromJson(json.decode(str));
String fetchFavoriteSoundModelToJson(FetchFavoriteSoundModel data) => json.encode(data.toJson());

class FetchFavoriteSoundModel {
  FetchFavoriteSoundModel({
    bool? status,
    String? message,
    List<FavoriteSongs>? songs,
  }) {
    _status = status;
    _message = message;
    _songs = songs;
  }

  FetchFavoriteSoundModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['songs'] != null) {
      _songs = [];
      json['songs'].forEach((v) {
        _songs?.add(FavoriteSongs.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<FavoriteSongs>? _songs;
  FetchFavoriteSoundModel copyWith({
    bool? status,
    String? message,
    List<FavoriteSongs>? songs,
  }) =>
      FetchFavoriteSoundModel(
        status: status ?? _status,
        message: message ?? _message,
        songs: songs ?? _songs,
      );
  bool? get status => _status;
  String? get message => _message;
  List<FavoriteSongs>? get songs => _songs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_songs != null) {
      map['songs'] = _songs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

FavoriteSongs songsFromJson(String str) => FavoriteSongs.fromJson(json.decode(str));
String songsToJson(FavoriteSongs data) => json.encode(data.toJson());

class FavoriteSongs {
  FavoriteSongs({
    String? id,
    String? userId,
    SongId? songId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _songId = songId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  FavoriteSongs.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _songId = json['songId'] != null ? SongId.fromJson(json['songId']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _userId;
  SongId? _songId;
  String? _createdAt;
  String? _updatedAt;
  FavoriteSongs copyWith({
    String? id,
    String? userId,
    SongId? songId,
    String? createdAt,
    String? updatedAt,
  }) =>
      FavoriteSongs(
        id: id ?? _id,
        userId: userId ?? _userId,
        songId: songId ?? _songId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get userId => _userId;
  SongId? get songId => _songId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    if (_songId != null) {
      map['songId'] = _songId?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

SongId songIdFromJson(String str) => SongId.fromJson(json.decode(str));
String songIdToJson(SongId data) => json.encode(data.toJson());

class SongId {
  SongId({
    String? id,
    String? singerName,
    String? songTitle,
    String? songLink,
    String? songImage,
    SongCategoryId? songCategoryId,
    double? songTime,
  }) {
    _id = id;
    _singerName = singerName;
    _songTitle = songTitle;
    _songLink = songLink;
    _songImage = songImage;
    _songCategoryId = songCategoryId;
    _songTime = songTime;
  }

  SongId.fromJson(dynamic json) {
    _id = json['_id'];
    _singerName = json['singerName'];
    _songTitle = json['songTitle'];
    _songLink = json['songLink'];
    _songImage = json['songImage'];
    _songCategoryId = json['songCategoryId'] != null ? SongCategoryId.fromJson(json['songCategoryId']) : null;
    _songTime = json['songTime'];
  }
  String? _id;
  String? _singerName;
  String? _songTitle;
  String? _songLink;
  String? _songImage;
  SongCategoryId? _songCategoryId;
  double? _songTime;
  SongId copyWith({
    String? id,
    String? singerName,
    String? songTitle,
    String? songLink,
    String? songImage,
    SongCategoryId? songCategoryId,
    double? songTime,
  }) =>
      SongId(
        id: id ?? _id,
        singerName: singerName ?? _singerName,
        songTitle: songTitle ?? _songTitle,
        songLink: songLink ?? _songLink,
        songImage: songImage ?? _songImage,
        songCategoryId: songCategoryId ?? _songCategoryId,
        songTime: songTime ?? _songTime,
      );
  String? get id => _id;
  String? get singerName => _singerName;
  String? get songTitle => _songTitle;
  String? get songLink => _songLink;
  String? get songImage => _songImage;
  SongCategoryId? get songCategoryId => _songCategoryId;
  double? get songTime => _songTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['singerName'] = _singerName;
    map['songTitle'] = _songTitle;
    map['songLink'] = _songLink;
    map['songImage'] = _songImage;
    if (_songCategoryId != null) {
      map['songCategoryId'] = _songCategoryId?.toJson();
    }
    map['songTime'] = _songTime;
    return map;
  }
}

SongCategoryId songCategoryIdFromJson(String str) => SongCategoryId.fromJson(json.decode(str));
String songCategoryIdToJson(SongCategoryId data) => json.encode(data.toJson());

class SongCategoryId {
  SongCategoryId({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  SongCategoryId.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  SongCategoryId copyWith({
    String? id,
    String? name,
  }) =>
      SongCategoryId(
        id: id ?? _id,
        name: name ?? _name,
      );
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }
}
