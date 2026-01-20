import 'dart:convert';

CreateWithdrawRequestModel createWithdrawRequestModelFromJson(String str) =>
    CreateWithdrawRequestModel.fromJson(json.decode(str));
String createWithdrawRequestModelToJson(CreateWithdrawRequestModel data) => json.encode(data.toJson());

class CreateWithdrawRequestModel {
  CreateWithdrawRequestModel({
    bool? status,
    String? message,
    WithDrawRequest? withDrawRequest,
  }) {
    _status = status;
    _message = message;
    _withDrawRequest = withDrawRequest;
  }

  CreateWithdrawRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _withDrawRequest = json['withDrawRequest'] != null ? WithDrawRequest.fromJson(json['withDrawRequest']) : null;
  }
  bool? _status;
  String? _message;
  WithDrawRequest? _withDrawRequest;
  CreateWithdrawRequestModel copyWith({
    bool? status,
    String? message,
    WithDrawRequest? withDrawRequest,
  }) =>
      CreateWithdrawRequestModel(
        status: status ?? _status,
        message: message ?? _message,
        withDrawRequest: withDrawRequest ?? _withDrawRequest,
      );
  bool? get status => _status;
  String? get message => _message;
  WithDrawRequest? get withDrawRequest => _withDrawRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_withDrawRequest != null) {
      map['withDrawRequest'] = _withDrawRequest?.toJson();
    }
    return map;
  }
}

WithDrawRequest withDrawRequestFromJson(String str) => WithDrawRequest.fromJson(json.decode(str));
String withDrawRequestToJson(WithDrawRequest data) => json.encode(data.toJson());

class WithDrawRequest {
  WithDrawRequest({
    String? id,
    String? userId,
    dynamic amount,
    int? coin,
    int? status,
    String? paymentGateway,
    List<String>? paymentDetails,
    String? reason,
    String? uniqueId,
    String? requestDate,
    String? acceptOrDeclineDate,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _amount = amount;
    _coin = coin;
    _status = status;
    _paymentGateway = paymentGateway;
    _paymentDetails = paymentDetails;
    _reason = reason;
    _uniqueId = uniqueId;
    _requestDate = requestDate;
    _acceptOrDeclineDate = acceptOrDeclineDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WithDrawRequest.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _amount = json['amount'];
    _coin = json['coin'];
    _status = json['status'];
    _paymentGateway = json['paymentGateway'];
    _paymentDetails = json['paymentDetails'] != null ? json['paymentDetails'].cast<String>() : [];
    _reason = json['reason'];
    _uniqueId = json['uniqueId'];
    _requestDate = json['requestDate'];
    _acceptOrDeclineDate = json['acceptOrDeclineDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _userId;
  dynamic _amount;
  int? _coin;
  int? _status;
  String? _paymentGateway;
  List<String>? _paymentDetails;
  String? _reason;
  String? _uniqueId;
  String? _requestDate;
  String? _acceptOrDeclineDate;
  String? _createdAt;
  String? _updatedAt;
  WithDrawRequest copyWith({
    String? id,
    String? userId,
    dynamic amount,
    int? coin,
    int? status,
    String? paymentGateway,
    List<String>? paymentDetails,
    String? reason,
    String? uniqueId,
    String? requestDate,
    String? acceptOrDeclineDate,
    String? createdAt,
    String? updatedAt,
  }) =>
      WithDrawRequest(
        id: id ?? _id,
        userId: userId ?? _userId,
        amount: amount ?? _amount,
        coin: coin ?? _coin,
        status: status ?? _status,
        paymentGateway: paymentGateway ?? _paymentGateway,
        paymentDetails: paymentDetails ?? _paymentDetails,
        reason: reason ?? _reason,
        uniqueId: uniqueId ?? _uniqueId,
        requestDate: requestDate ?? _requestDate,
        acceptOrDeclineDate: acceptOrDeclineDate ?? _acceptOrDeclineDate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get userId => _userId;
  dynamic get amount => _amount;
  int? get coin => _coin;
  int? get status => _status;
  String? get paymentGateway => _paymentGateway;
  List<String>? get paymentDetails => _paymentDetails;
  String? get reason => _reason;
  String? get uniqueId => _uniqueId;
  String? get requestDate => _requestDate;
  String? get acceptOrDeclineDate => _acceptOrDeclineDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['amount'] = _amount;
    map['coin'] = _coin;
    map['status'] = _status;
    map['paymentGateway'] = _paymentGateway;
    map['paymentDetails'] = _paymentDetails;
    map['reason'] = _reason;
    map['uniqueId'] = _uniqueId;
    map['requestDate'] = _requestDate;
    map['acceptOrDeclineDate'] = _acceptOrDeclineDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
