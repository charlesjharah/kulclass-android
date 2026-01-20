class FetchLiveUserModel {
  bool? status;
  String? message;
  List<LiveUserList>? liveUserList;

  FetchLiveUserModel({this.status, this.message, this.liveUserList});

  FetchLiveUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['liveUserList'] != null) {
      liveUserList = <LiveUserList>[];
      json['liveUserList'].forEach((v) {
        liveUserList!.add(new LiveUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.liveUserList != null) {
      data['liveUserList'] = this.liveUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveUserList {
  String? id;
  String? videoUrl;
  bool? isLive;
  int? view;
  String? liveHistoryId;
  bool? isFollow;
  String? name;
  String? userName;
  String? image;
  bool? isVerified;
  String? countryFlagImage;
  bool? isFake;
  bool? isProfileImageBanned;

  LiveUserList(
      {this.id,
      this.videoUrl,
      this.isLive,
      this.view,
      this.liveHistoryId,
      this.isFollow,
      this.name,
      this.userName,
      this.image,
      this.isVerified,
      this.countryFlagImage,
      this.isFake,
      this.isProfileImageBanned});

  LiveUserList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    videoUrl = json['videoUrl'];
    isLive = json['isLive'];
    view = json['view'];
    liveHistoryId = json['liveHistoryId'];
    isFollow = json['isFollow'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isVerified = json['isVerified'];
    countryFlagImage = json['countryFlagImage'];
    isFake = json['isFake'];
    isProfileImageBanned = json['isProfileImageBanned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['videoUrl'] = this.videoUrl;
    data['isLive'] = this.isLive;
    data['view'] = this.view;
    data['liveHistoryId'] = this.liveHistoryId;
    data['isFollow'] = this.isFollow;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['isVerified'] = this.isVerified;
    data['countryFlagImage'] = this.countryFlagImage;
    data['isFake'] = this.isFake;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    return data;
  }
}
