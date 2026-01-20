import 'dart:convert';

FetchAllSoundModel fetchAllSoundModelFromJson(String str) => FetchAllSoundModel.fromJson(json.decode(str));
String fetchAllSoundModelToJson(FetchAllSoundModel data) => json.encode(data.toJson());

class FetchAllSoundModel {
  FetchAllSoundModel({
    bool? status,
    String? message,
    List<AllSongs>? songs,
  }) {
    _status = status;
    _message = message;
    _songs = songs;
  }

  FetchAllSoundModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['songs'] != null) {
      _songs = [];
      json['songs'].forEach((v) {
        _songs?.add(AllSongs.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<AllSongs>? _songs;
  FetchAllSoundModel copyWith({
    bool? status,
    String? message,
    List<AllSongs>? songs,
  }) =>
      FetchAllSoundModel(
        status: status ?? _status,
        message: message ?? _message,
        songs: songs ?? _songs,
      );
  bool? get status => _status;
  String? get message => _message;
  List<AllSongs>? get songs => _songs;

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

AllSongs songsFromJson(String str) => AllSongs.fromJson(json.decode(str));
String songsToJson(AllSongs data) => json.encode(data.toJson());

class AllSongs {
  AllSongs({
    String? id,
    String? singerName,
    String? songTitle,
    String? songLink,
    String? songImage,
    double? songTime,
    String? createdAt,
    String? songCategoryName,
    String? songCategoryImage,
    bool? isFavorite,
  }) {
    _id = id;
    _singerName = singerName;
    _songTitle = songTitle;
    _songLink = songLink;
    _songImage = songImage;
    _songTime = songTime;
    _createdAt = createdAt;
    _songCategoryName = songCategoryName;
    _songCategoryImage = songCategoryImage;
    _isFavorite = isFavorite;
  }

  AllSongs.fromJson(dynamic json) {
    _id = json['_id'];
    _singerName = json['singerName'];
    _songTitle = json['songTitle'];
    _songLink = json['songLink'];
    _songImage = json['songImage'];
    _songTime = json['songTime'];
    _createdAt = json['createdAt'];
    _songCategoryName = json['songCategoryName'];
    _songCategoryImage = json['songCategoryImage'];
    _isFavorite = json['isFavorite'];
  }
  String? _id;
  String? _singerName;
  String? _songTitle;
  String? _songLink;
  String? _songImage;
  double? _songTime;
  String? _createdAt;
  String? _songCategoryName;
  String? _songCategoryImage;
  bool? _isFavorite;
  AllSongs copyWith({
    String? id,
    String? singerName,
    String? songTitle,
    String? songLink,
    String? songImage,
    double? songTime,
    String? createdAt,
    String? songCategoryName,
    String? songCategoryImage,
    bool? isFavorite,
  }) =>
      AllSongs(
        id: id ?? _id,
        singerName: singerName ?? _singerName,
        songTitle: songTitle ?? _songTitle,
        songLink: songLink ?? _songLink,
        songImage: songImage ?? _songImage,
        songTime: songTime ?? _songTime,
        createdAt: createdAt ?? _createdAt,
        songCategoryName: songCategoryName ?? _songCategoryName,
        songCategoryImage: songCategoryImage ?? _songCategoryImage,
        isFavorite: isFavorite ?? _isFavorite,
      );
  String? get id => _id;
  String? get singerName => _singerName;
  String? get songTitle => _songTitle;
  String? get songLink => _songLink;
  String? get songImage => _songImage;
  double? get songTime => _songTime;
  String? get createdAt => _createdAt;
  String? get songCategoryName => _songCategoryName;
  String? get songCategoryImage => _songCategoryImage;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['singerName'] = _singerName;
    map['songTitle'] = _songTitle;
    map['songLink'] = _songLink;
    map['songImage'] = _songImage;
    map['songTime'] = _songTime;
    map['createdAt'] = _createdAt;
    map['songCategoryName'] = _songCategoryName;
    map['songCategoryImage'] = _songCategoryImage;
    map['isFavorite'] = _isFavorite;
    return map;
  }
}
