class FetchAiCaptionModel {
  FetchAiCaptionModel({
    bool? status,
    String? message,
    String? caption,
    List<String>? hashtags,
  }) {
    _status = status;
    _message = message;
    _caption = caption;
    _hashtags = hashtags;
  }

  FetchAiCaptionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _caption = json['caption'];
    _hashtags = json['hashtags'] != null ? json['hashtags'].cast<String>() : [];
  }
  bool? _status;
  String? _message;
  String? _caption;
  List<String>? _hashtags;
  FetchAiCaptionModel copyWith({
    bool? status,
    String? message,
    String? caption,
    List<String>? hashtags,
  }) =>
      FetchAiCaptionModel(
        status: status ?? _status,
        message: message ?? _message,
        caption: caption ?? _caption,
        hashtags: hashtags ?? _hashtags,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get caption => _caption;
  List<String>? get hashtags => _hashtags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['caption'] = _caption;
    map['hashtags'] = _hashtags;
    return map;
  }
}
