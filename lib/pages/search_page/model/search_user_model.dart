class SearchUserModel {
  bool? status;
  String? message;
  List<SearchUserData>? searchData;

  SearchUserModel({this.status, this.message, this.searchData});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['searchData'] != null) {
      searchData = <SearchUserData>[];
      json['searchData'].forEach((v) {
        searchData!.add(new SearchUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.searchData != null) {
      data['searchData'] = this.searchData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchUserData {
  String? id;
  String? name;
  String? userName;
  String? image;
  bool? isProfileImageBanned;
  bool? isFake;
  bool? isVerified;

  SearchUserData({this.id, this.name, this.userName, this.image, this.isProfileImageBanned, this.isFake, this.isVerified});

  SearchUserData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isProfileImageBanned = json['isProfileImageBanned'];
    isFake = json['isFake'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['isFake'] = this.isFake;
    data['isVerified'] = this.isVerified;
    return data;
  }
}
