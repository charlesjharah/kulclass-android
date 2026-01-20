class SearchMessageUserModel {
  bool? status;
  String? message;
  List<SearchUserData>? data;

  SearchMessageUserModel({this.status, this.message, this.data});

  SearchMessageUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchUserData>[];
      json['data'].forEach((v) {
        data!.add(new SearchUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchUserData {
  String? id;
  bool? isProfileImageBanned;
  String? name;
  String? userName;
  String? image;
  bool? isVerified;
  bool? isFake;

  SearchUserData({this.id, this.isProfileImageBanned, this.name, this.userName, this.image, this.isVerified, this.isFake});

  SearchUserData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isProfileImageBanned = json['isProfileImageBanned'];
    name = json['name'];
    userName = json['userName'];
    image = json['image'];
    isVerified = json['isVerified'];
    isFake = json['isFake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['isProfileImageBanned'] = this.isProfileImageBanned;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['isVerified'] = this.isVerified;
    data['isFake'] = this.isFake;
    return data;
  }
}
