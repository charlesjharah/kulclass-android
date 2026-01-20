import 'dart:convert';

CreateVerificationRequestModel createVerificationRequestModelFromJson(String str) =>
    CreateVerificationRequestModel.fromJson(json.decode(str));
String createVerificationRequestModelToJson(CreateVerificationRequestModel data) => json.encode(data.toJson());

class CreateVerificationRequestModel {
  CreateVerificationRequestModel({
    bool? status,
    String? message,
    VerificationRequest? verificationRequest,
  }) {
    _status = status;
    _message = message;
    _verificationRequest = verificationRequest;
  }

  CreateVerificationRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _verificationRequest =
        json['verificationRequest'] != null ? VerificationRequest.fromJson(json['verificationRequest']) : null;
  }
  bool? _status;
  String? _message;
  VerificationRequest? _verificationRequest;
  CreateVerificationRequestModel copyWith({
    bool? status,
    String? message,
    VerificationRequest? verificationRequest,
  }) =>
      CreateVerificationRequestModel(
        status: status ?? _status,
        message: message ?? _message,
        verificationRequest: verificationRequest ?? _verificationRequest,
      );
  bool? get status => _status;
  String? get message => _message;
  VerificationRequest? get verificationRequest => _verificationRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_verificationRequest != null) {
      map['verificationRequest'] = _verificationRequest?.toJson();
    }
    return map;
  }
}

VerificationRequest verificationRequestFromJson(String str) => VerificationRequest.fromJson(json.decode(str));
String verificationRequestToJson(VerificationRequest data) => json.encode(data.toJson());

class VerificationRequest {
  VerificationRequest({
    String? userId,
    String? profileSelfie,
    String? document,
    String? documentId,
    String? nameOnDocument,
    String? address,
    String? date,
    dynamic reason,
    bool? isAccepted,
    bool? isRejected,
    String? id,
    int? documentType,
    String? createdAt,
    String? updatedAt,
  }) {
    _userId = userId;
    _profileSelfie = profileSelfie;
    _document = document;
    _documentId = documentId;
    _nameOnDocument = nameOnDocument;
    _address = address;
    _date = date;
    _reason = reason;
    _isAccepted = isAccepted;
    _isRejected = isRejected;
    _id = id;
    _documentType = documentType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  VerificationRequest.fromJson(dynamic json) {
    _userId = json['userId'];
    _profileSelfie = json['profileSelfie'];
    _document = json['document'];
    _documentId = json['documentId'];
    _nameOnDocument = json['nameOnDocument'];
    _address = json['address'];
    _date = json['date'];
    _reason = json['reason'];
    _isAccepted = json['isAccepted'];
    _isRejected = json['isRejected'];
    _id = json['_id'];
    _documentType = json['documentType'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _userId;
  String? _profileSelfie;
  String? _document;
  String? _documentId;
  String? _nameOnDocument;
  String? _address;
  String? _date;
  dynamic _reason;
  bool? _isAccepted;
  bool? _isRejected;
  String? _id;
  int? _documentType;
  String? _createdAt;
  String? _updatedAt;
  VerificationRequest copyWith({
    String? userId,
    String? profileSelfie,
    String? document,
    String? documentId,
    String? nameOnDocument,
    String? address,
    String? date,
    dynamic reason,
    bool? isAccepted,
    bool? isRejected,
    String? id,
    int? documentType,
    String? createdAt,
    String? updatedAt,
  }) =>
      VerificationRequest(
        userId: userId ?? _userId,
        profileSelfie: profileSelfie ?? _profileSelfie,
        document: document ?? _document,
        documentId: documentId ?? _documentId,
        nameOnDocument: nameOnDocument ?? _nameOnDocument,
        address: address ?? _address,
        date: date ?? _date,
        reason: reason ?? _reason,
        isAccepted: isAccepted ?? _isAccepted,
        isRejected: isRejected ?? _isRejected,
        id: id ?? _id,
        documentType: documentType ?? _documentType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get userId => _userId;
  String? get profileSelfie => _profileSelfie;
  String? get document => _document;
  String? get documentId => _documentId;
  String? get nameOnDocument => _nameOnDocument;
  String? get address => _address;
  String? get date => _date;
  dynamic get reason => _reason;
  bool? get isAccepted => _isAccepted;
  bool? get isRejected => _isRejected;
  String? get id => _id;
  int? get documentType => _documentType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['profileSelfie'] = _profileSelfie;
    map['document'] = _document;
    map['documentId'] = _documentId;
    map['nameOnDocument'] = _nameOnDocument;
    map['address'] = _address;
    map['date'] = _date;
    map['reason'] = _reason;
    map['isAccepted'] = _isAccepted;
    map['isRejected'] = _isRejected;
    map['_id'] = _id;
    map['documentType'] = _documentType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
