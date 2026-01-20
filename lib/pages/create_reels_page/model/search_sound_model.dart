// To parse this JSON data, do
//
//     final searchSoundModel = searchSoundModelFromJson(jsonString);

import 'dart:convert';

SearchSoundModel searchSoundModelFromJson(String str) => SearchSoundModel.fromJson(json.decode(str));

String searchSoundModelToJson(SearchSoundModel data) => json.encode(data.toJson());

class SearchSoundModel {
  bool? status;
  String? message;
  List<SearchData>? searchData;

  SearchSoundModel({
    this.status,
    this.message,
    this.searchData,
  });

  factory SearchSoundModel.fromJson(Map<String, dynamic> json) => SearchSoundModel(
        status: json["status"],
        message: json["message"],
        searchData: json["searchData"] == null
            ? []
            : List<SearchData>.from(json["searchData"]!.map((x) => SearchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "searchData": searchData == null ? [] : List<dynamic>.from(searchData!.map((x) => x.toJson())),
      };
}

class SearchData {
  String? id;
  String? singerName;
  String? songTitle;
  String? songLink;
  String? songImage;
  double? songTime;
  DateTime? createdAt;
  String? songCategoryName;
  bool? isFavorite;

  SearchData({
    this.id,
    this.singerName,
    this.songTitle,
    this.songLink,
    this.songImage,
    this.songTime,
    this.createdAt,
    this.songCategoryName,
    this.isFavorite,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        id: json["_id"],
        singerName: json["singerName"],
        songTitle: json["songTitle"],
        songLink: json["songLink"],
        songImage: json["songImage"],
        songTime: json["songTime"]?.toDouble(),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        songCategoryName: json["songCategoryName"],
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "singerName": singerName,
        "songTitle": songTitle,
        "songLink": songLink,
        "songImage": songImage,
        "songTime": songTime,
        "createdAt": createdAt?.toIso8601String(),
        "songCategoryName": songCategoryName,
        "isFavorite": isFavorite,
      };
}
