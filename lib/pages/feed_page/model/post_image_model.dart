class PostImage {
  String? url;
  bool? isBanned;
  String? id;

  PostImage({this.url, this.isBanned, this.id});

  PostImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    isBanned = json['isBanned'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['isBanned'] = this.isBanned;
    data['_id'] = this.id;
    return data;
  }
}
