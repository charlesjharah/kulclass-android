// To parse this JSON data, do
//
//     final editUploadVideoModel = editUploadVideoModelFromJson(jsonString);

import 'dart:convert';

EditReelsModel editUploadVideoModelFromJson(String str) => EditReelsModel.fromJson(json.decode(str));

String editUploadVideoModelToJson(EditReelsModel data) => json.encode(data.toJson());

class EditReelsModel {
  bool? status;
  String? message;
  Data? data;

  EditReelsModel({
    this.status,
    this.message,
    this.data,
  });

  factory EditReelsModel.fromJson(Map<String, dynamic> json) => EditReelsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  LocationCoordinates? locationCoordinates;
  String? id;
  String? uniqueVideoId;
  String? caption;
  String? videoUrl;
  String? videoImage;
  String? location;
  List<dynamic>? hashTagId;
  dynamic songId;
  String? userId;
  int? shareCount;
  bool? isFake;
  bool? isBanned;
  int? videoTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.locationCoordinates,
    this.id,
    this.uniqueVideoId,
    this.caption,
    this.videoUrl,
    this.videoImage,
    this.location,
    this.hashTagId,
    this.songId,
    this.userId,
    this.shareCount,
    this.isFake,
    this.isBanned,
    this.videoTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        locationCoordinates: json["locationCoordinates"] == null ? null : LocationCoordinates.fromJson(json["locationCoordinates"]),
        id: json["_id"],
        uniqueVideoId: json["uniqueVideoId"],
        caption: json["caption"],
        videoUrl: json["videoUrl"],
        videoImage: json["videoImage"],
        location: json["location"],
        hashTagId: json["hashTagId"] == null ? [] : List<dynamic>.from(json["hashTagId"]!.map((x) => x)),
        songId: json["songId"],
        userId: json["userId"],
        shareCount: json["shareCount"],
        isFake: json["isFake"],
        isBanned: json["isBanned"],
        videoTime: json["videoTime"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "locationCoordinates": locationCoordinates?.toJson(),
        "_id": id,
        "uniqueVideoId": uniqueVideoId,
        "caption": caption,
        "videoUrl": videoUrl,
        "videoImage": videoImage,
        "location": location,
        "hashTagId": hashTagId == null ? [] : List<dynamic>.from(hashTagId!.map((x) => x)),
        "songId": songId,
        "userId": userId,
        "shareCount": shareCount,
        "isFake": isFake,
        "isBanned": isBanned,
        "videoTime": videoTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class LocationCoordinates {
  String? latitude;
  String? longitude;

  LocationCoordinates({
    this.latitude,
    this.longitude,
  });

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) => LocationCoordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
