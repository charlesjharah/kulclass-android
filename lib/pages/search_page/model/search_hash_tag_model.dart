import 'dart:convert';

SearchHashTagModel searchHashTagModelFromJson(String str) => SearchHashTagModel.fromJson(json.decode(str));
String searchHashTagModelToJson(SearchHashTagModel data) => json.encode(data.toJson());

class SearchHashTagModel {
  SearchHashTagModel({
    bool? status,
    String? message,
    List<SearchHashTagData>? searchData,
  }) {
    _status = status;
    _message = message;
    _searchData = searchData;
  }

  SearchHashTagModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['searchData'] != null) {
      _searchData = [];
      json['searchData'].forEach((v) {
        _searchData?.add(SearchHashTagData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<SearchHashTagData>? _searchData;
  SearchHashTagModel copyWith({
    bool? status,
    String? message,
    List<SearchHashTagData>? searchData,
  }) =>
      SearchHashTagModel(
        status: status ?? _status,
        message: message ?? _message,
        searchData: searchData ?? _searchData,
      );
  bool? get status => _status;
  String? get message => _message;
  List<SearchHashTagData>? get searchData => _searchData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_searchData != null) {
      map['searchData'] = _searchData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

SearchHashTagData searchDataFromJson(String str) => SearchHashTagData.fromJson(json.decode(str));
String searchDataToJson(SearchHashTagData data) => json.encode(data.toJson());

class SearchHashTagData {
  SearchHashTagData({
    String? id,
    String? hashTag,
    String? hashTagIcon,
    String? hashTagBanner,
    int? totalVideo,
    int? totalPost,
  }) {
    _id = id;
    _hashTag = hashTag;
    _hashTagIcon = hashTagIcon;
    _hashTagBanner = hashTagBanner;
    _totalVideo = totalVideo;
    _totalPost = totalPost;
  }

  SearchHashTagData.fromJson(dynamic json) {
    _id = json['_id'];
    _hashTag = json['hashTag'];
    _hashTagIcon = json['hashTagIcon'];
    _hashTagBanner = json['hashTagBanner'];
    _totalVideo = json['totalVideo'];
    _totalPost = json['totalPost'];
  }
  String? _id;
  String? _hashTag;
  String? _hashTagIcon;
  String? _hashTagBanner;
  int? _totalVideo;
  int? _totalPost;
  SearchHashTagData copyWith({
    String? id,
    String? hashTag,
    String? hashTagIcon,
    String? hashTagBanner,
    int? totalVideo,
    int? totalPost,
  }) =>
      SearchHashTagData(
        id: id ?? _id,
        hashTag: hashTag ?? _hashTag,
        hashTagIcon: hashTagIcon ?? _hashTagIcon,
        hashTagBanner: hashTagBanner ?? _hashTagBanner,
        totalVideo: totalVideo ?? _totalVideo,
        totalPost: totalPost ?? _totalPost,
      );
  String? get id => _id;
  String? get hashTag => _hashTag;
  String? get hashTagIcon => _hashTagIcon;
  String? get hashTagBanner => _hashTagBanner;
  int? get totalVideo => _totalVideo;
  int? get totalPost => _totalPost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hashTag'] = _hashTag;
    map['hashTagIcon'] = _hashTagIcon;
    map['hashTagBanner'] = _hashTagBanner;
    map['totalVideo'] = _totalVideo;
    map['totalPost'] = _totalPost;
    return map;
  }
}
