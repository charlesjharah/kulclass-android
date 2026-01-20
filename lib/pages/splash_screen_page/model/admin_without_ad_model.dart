// import 'dart:convert';
//
// AdminSettingModel adminSettingModelFromJson(String str) => AdminSettingModel.fromJson(json.decode(str));
// String adminSettingModelToJson(AdminSettingModel data) => json.encode(data.toJson());
//
// class AdminSettingModel {
//   AdminSettingModel({
//     bool? status,
//     String? message,
//     Data? data,
//   }) {
//     _status = status;
//     _message = message;
//     _data = data;
//   }
//
//   AdminSettingModel.fromJson(dynamic json) {
//     _status = json['status'];
//     _message = json['message'];
//     _data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   bool? _status;
//   String? _message;
//   Data? _data;
//   AdminSettingModel copyWith({
//     bool? status,
//     String? message,
//     Data? data,
//   }) =>
//       AdminSettingModel(
//         status: status ?? _status,
//         message: message ?? _message,
//         data: data ?? _data,
//       );
//   bool? get status => _status;
//   String? get message => _message;
//   Data? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
// }
//
// Data dataFromJson(String str) => Data.fromJson(json.decode(str));
// String dataToJson(Data data) => json.encode(data.toJson());
//
// class Data {
//   Data({
//     Currency? currency,
//     String? id,
//     bool? stripeSwitch,
//     String? stripePublishableKey,
//     String? stripeSecretKey,
//     bool? razorPaySwitch,
//     String? razorPayId,
//     String? razorSecretKey,
//     String? privacyPolicyLink,
//     String? termsOfUsePolicyLink,
//     String? zegoAppId,
//     String? zegoAppSignIn,
//     List<String>? paymentGateway,
//     bool? isFakeData,
//     int? durationOfShorts,
//     int? minCoinForCashOut,
//     int? minWithdrawalRequestedCoin,
//     String? createdAt,
//     String? updatedAt,
//     PrivateKey? privateKey,
//     List<String>? videoBanned,
//     bool? googlePlaySwitch,
//     String? androidLicenseKey,
//     String? iosLicenseKey,
//   }) {
//     _currency = currency;
//     _id = id;
//     _stripeSwitch = stripeSwitch;
//     _stripePublishableKey = stripePublishableKey;
//     _stripeSecretKey = stripeSecretKey;
//     _razorPaySwitch = razorPaySwitch;
//     _razorPayId = razorPayId;
//     _razorSecretKey = razorSecretKey;
//     _privacyPolicyLink = privacyPolicyLink;
//     _termsOfUsePolicyLink = termsOfUsePolicyLink;
//     _zegoAppId = zegoAppId;
//     _zegoAppSignIn = zegoAppSignIn;
//     _paymentGateway = paymentGateway;
//     _isFakeData = isFakeData;
//     _durationOfShorts = durationOfShorts;
//     _minCoinForCashOut = minCoinForCashOut;
//     _minWithdrawalRequestedCoin = minWithdrawalRequestedCoin;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _privateKey = privateKey;
//     _videoBanned = videoBanned;
//     _googlePlaySwitch = googlePlaySwitch;
//     _androidLicenseKey = androidLicenseKey;
//     _iosLicenseKey = iosLicenseKey;
//   }
//
//   Data.fromJson(dynamic json) {
//     _currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
//     _id = json['_id'];
//     _stripeSwitch = json['stripeSwitch'];
//     _stripePublishableKey = json['stripePublishableKey'];
//     _stripeSecretKey = json['stripeSecretKey'];
//     _razorPaySwitch = json['razorPaySwitch'];
//     _razorPayId = json['razorPayId'];
//     _razorSecretKey = json['razorSecretKey'];
//     _privacyPolicyLink = json['privacyPolicyLink'];
//     _termsOfUsePolicyLink = json['termsOfUsePolicyLink'];
//     _zegoAppId = json['zegoAppId'];
//     _zegoAppSignIn = json['zegoAppSignIn'];
//     _paymentGateway = json['paymentGateway'] != null ? json['paymentGateway'].cast<String>() : [];
//     _isFakeData = json['isFakeData'];
//     _durationOfShorts = json['durationOfShorts'];
//     _minCoinForCashOut = json['minCoinForCashOut'];
//     _minWithdrawalRequestedCoin = json['minWithdrawalRequestedCoin'];
//     _createdAt = json['createdAt'];
//     _updatedAt = json['updatedAt'];
//     _privateKey = json['privateKey'] != null ? PrivateKey.fromJson(json['privateKey']) : null;
//     _videoBanned = json['videoBanned'] != null ? json['videoBanned'].cast<String>() : [];
//     _googlePlaySwitch = json['googlePlaySwitch'];
//     _androidLicenseKey = json['androidLicenseKey'];
//     _iosLicenseKey = json['iosLicenseKey'];
//   }
//   Currency? _currency;
//   String? _id;
//   bool? _stripeSwitch;
//   String? _stripePublishableKey;
//   String? _stripeSecretKey;
//   bool? _razorPaySwitch;
//   String? _razorPayId;
//   String? _razorSecretKey;
//   String? _privacyPolicyLink;
//   String? _termsOfUsePolicyLink;
//   String? _zegoAppId;
//   String? _zegoAppSignIn;
//   List<String>? _paymentGateway;
//   bool? _isFakeData;
//   int? _durationOfShorts;
//   int? _minCoinForCashOut;
//   int? _minWithdrawalRequestedCoin;
//   String? _createdAt;
//   String? _updatedAt;
//   PrivateKey? _privateKey;
//   List<String>? _videoBanned;
//   bool? _googlePlaySwitch;
//   String? _androidLicenseKey;
//   String? _iosLicenseKey;
//   Data copyWith({
//     Currency? currency,
//     String? id,
//     bool? stripeSwitch,
//     String? stripePublishableKey,
//     String? stripeSecretKey,
//     bool? razorPaySwitch,
//     String? razorPayId,
//     String? razorSecretKey,
//     String? privacyPolicyLink,
//     String? termsOfUsePolicyLink,
//     String? zegoAppId,
//     String? zegoAppSignIn,
//     List<String>? paymentGateway,
//     bool? isFakeData,
//     int? durationOfShorts,
//     int? minCoinForCashOut,
//     int? minWithdrawalRequestedCoin,
//     String? createdAt,
//     String? updatedAt,
//     PrivateKey? privateKey,
//     List<String>? videoBanned,
//     bool? googlePlaySwitch,
//     String? androidLicenseKey,
//     String? iosLicenseKey,
//   }) =>
//       Data(
//         currency: currency ?? _currency,
//         id: id ?? _id,
//         stripeSwitch: stripeSwitch ?? _stripeSwitch,
//         stripePublishableKey: stripePublishableKey ?? _stripePublishableKey,
//         stripeSecretKey: stripeSecretKey ?? _stripeSecretKey,
//         razorPaySwitch: razorPaySwitch ?? _razorPaySwitch,
//         razorPayId: razorPayId ?? _razorPayId,
//         razorSecretKey: razorSecretKey ?? _razorSecretKey,
//         privacyPolicyLink: privacyPolicyLink ?? _privacyPolicyLink,
//         termsOfUsePolicyLink: termsOfUsePolicyLink ?? _termsOfUsePolicyLink,
//         zegoAppId: zegoAppId ?? _zegoAppId,
//         zegoAppSignIn: zegoAppSignIn ?? _zegoAppSignIn,
//         paymentGateway: paymentGateway ?? _paymentGateway,
//         isFakeData: isFakeData ?? _isFakeData,
//         durationOfShorts: durationOfShorts ?? _durationOfShorts,
//         minCoinForCashOut: minCoinForCashOut ?? _minCoinForCashOut,
//         minWithdrawalRequestedCoin: minWithdrawalRequestedCoin ?? _minWithdrawalRequestedCoin,
//         createdAt: createdAt ?? _createdAt,
//         updatedAt: updatedAt ?? _updatedAt,
//         privateKey: privateKey ?? _privateKey,
//         videoBanned: videoBanned ?? _videoBanned,
//         googlePlaySwitch: googlePlaySwitch ?? _googlePlaySwitch,
//         androidLicenseKey: androidLicenseKey ?? _androidLicenseKey,
//         iosLicenseKey: iosLicenseKey ?? _iosLicenseKey,
//       );
//   Currency? get currency => _currency;
//   String? get id => _id;
//   bool? get stripeSwitch => _stripeSwitch;
//   String? get stripePublishableKey => _stripePublishableKey;
//   String? get stripeSecretKey => _stripeSecretKey;
//   bool? get razorPaySwitch => _razorPaySwitch;
//   String? get razorPayId => _razorPayId;
//   String? get razorSecretKey => _razorSecretKey;
//   String? get privacyPolicyLink => _privacyPolicyLink;
//   String? get termsOfUsePolicyLink => _termsOfUsePolicyLink;
//   String? get zegoAppId => _zegoAppId;
//   String? get zegoAppSignIn => _zegoAppSignIn;
//   List<String>? get paymentGateway => _paymentGateway;
//   bool? get isFakeData => _isFakeData;
//   int? get durationOfShorts => _durationOfShorts;
//   int? get minCoinForCashOut => _minCoinForCashOut;
//   int? get minWithdrawalRequestedCoin => _minWithdrawalRequestedCoin;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   PrivateKey? get privateKey => _privateKey;
//   List<String>? get videoBanned => _videoBanned;
//   bool? get googlePlaySwitch => _googlePlaySwitch;
//   String? get androidLicenseKey => _androidLicenseKey;
//   String? get iosLicenseKey => _iosLicenseKey;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_currency != null) {
//       map['currency'] = _currency?.toJson();
//     }
//     map['_id'] = _id;
//     map['stripeSwitch'] = _stripeSwitch;
//     map['stripePublishableKey'] = _stripePublishableKey;
//     map['stripeSecretKey'] = _stripeSecretKey;
//     map['razorPaySwitch'] = _razorPaySwitch;
//     map['razorPayId'] = _razorPayId;
//     map['razorSecretKey'] = _razorSecretKey;
//     map['privacyPolicyLink'] = _privacyPolicyLink;
//     map['termsOfUsePolicyLink'] = _termsOfUsePolicyLink;
//     map['zegoAppId'] = _zegoAppId;
//     map['zegoAppSignIn'] = _zegoAppSignIn;
//     map['paymentGateway'] = _paymentGateway;
//     map['isFakeData'] = _isFakeData;
//     map['durationOfShorts'] = _durationOfShorts;
//     map['minCoinForCashOut'] = _minCoinForCashOut;
//     map['minWithdrawalRequestedCoin'] = _minWithdrawalRequestedCoin;
//     map['createdAt'] = _createdAt;
//     map['updatedAt'] = _updatedAt;
//     if (_privateKey != null) {
//       map['privateKey'] = _privateKey?.toJson();
//     }
//     map['videoBanned'] = _videoBanned;
//     map['googlePlaySwitch'] = _googlePlaySwitch;
//     map['androidLicenseKey'] = _androidLicenseKey;
//     map['iosLicenseKey'] = _iosLicenseKey;
//     return map;
//   }
// }
//
// PrivateKey privateKeyFromJson(String str) => PrivateKey.fromJson(json.decode(str));
// String privateKeyToJson(PrivateKey data) => json.encode(data.toJson());
//
// class PrivateKey {
//   PrivateKey({
//     String? type,
//     String? projectId,
//     String? privateKeyId,
//     String? privateKey,
//     String? clientEmail,
//     String? clientId,
//     String? authUri,
//     String? tokenUri,
//     String? authProviderX509CertUrl,
//     String? clientX509CertUrl,
//     String? universeDomain,
//   }) {
//     _type = type;
//     _projectId = projectId;
//     _privateKeyId = privateKeyId;
//     _privateKey = privateKey;
//     _clientEmail = clientEmail;
//     _clientId = clientId;
//     _authUri = authUri;
//     _tokenUri = tokenUri;
//     _authProviderX509CertUrl = authProviderX509CertUrl;
//     _clientX509CertUrl = clientX509CertUrl;
//     _universeDomain = universeDomain;
//   }
//
//   PrivateKey.fromJson(dynamic json) {
//     _type = json['type'];
//     _projectId = json['project_id'];
//     _privateKeyId = json['private_key_id'];
//     _privateKey = json['private_key'];
//     _clientEmail = json['client_email'];
//     _clientId = json['client_id'];
//     _authUri = json['auth_uri'];
//     _tokenUri = json['token_uri'];
//     _authProviderX509CertUrl = json['auth_provider_x509_cert_url'];
//     _clientX509CertUrl = json['client_x509_cert_url'];
//     _universeDomain = json['universe_domain'];
//   }
//   String? _type;
//   String? _projectId;
//   String? _privateKeyId;
//   String? _privateKey;
//   String? _clientEmail;
//   String? _clientId;
//   String? _authUri;
//   String? _tokenUri;
//   String? _authProviderX509CertUrl;
//   String? _clientX509CertUrl;
//   String? _universeDomain;
//   PrivateKey copyWith({
//     String? type,
//     String? projectId,
//     String? privateKeyId,
//     String? privateKey,
//     String? clientEmail,
//     String? clientId,
//     String? authUri,
//     String? tokenUri,
//     String? authProviderX509CertUrl,
//     String? clientX509CertUrl,
//     String? universeDomain,
//   }) =>
//       PrivateKey(
//         type: type ?? _type,
//         projectId: projectId ?? _projectId,
//         privateKeyId: privateKeyId ?? _privateKeyId,
//         privateKey: privateKey ?? _privateKey,
//         clientEmail: clientEmail ?? _clientEmail,
//         clientId: clientId ?? _clientId,
//         authUri: authUri ?? _authUri,
//         tokenUri: tokenUri ?? _tokenUri,
//         authProviderX509CertUrl: authProviderX509CertUrl ?? _authProviderX509CertUrl,
//         clientX509CertUrl: clientX509CertUrl ?? _clientX509CertUrl,
//         universeDomain: universeDomain ?? _universeDomain,
//       );
//   String? get type => _type;
//   String? get projectId => _projectId;
//   String? get privateKeyId => _privateKeyId;
//   String? get privateKey => _privateKey;
//   String? get clientEmail => _clientEmail;
//   String? get clientId => _clientId;
//   String? get authUri => _authUri;
//   String? get tokenUri => _tokenUri;
//   String? get authProviderX509CertUrl => _authProviderX509CertUrl;
//   String? get clientX509CertUrl => _clientX509CertUrl;
//   String? get universeDomain => _universeDomain;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['type'] = _type;
//     map['project_id'] = _projectId;
//     map['private_key_id'] = _privateKeyId;
//     map['private_key'] = _privateKey;
//     map['client_email'] = _clientEmail;
//     map['client_id'] = _clientId;
//     map['auth_uri'] = _authUri;
//     map['token_uri'] = _tokenUri;
//     map['auth_provider_x509_cert_url'] = _authProviderX509CertUrl;
//     map['client_x509_cert_url'] = _clientX509CertUrl;
//     map['universe_domain'] = _universeDomain;
//     return map;
//   }
// }
//
// Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));
// String currencyToJson(Currency data) => json.encode(data.toJson());
//
// class Currency {
//   Currency({
//     String? name,
//     String? symbol,
//     String? countryCode,
//     String? currencyCode,
//     bool? isDefault,
//   }) {
//     _name = name;
//     _symbol = symbol;
//     _countryCode = countryCode;
//     _currencyCode = currencyCode;
//     _isDefault = isDefault;
//   }
//
//   Currency.fromJson(dynamic json) {
//     _name = json['name'];
//     _symbol = json['symbol'];
//     _countryCode = json['countryCode'];
//     _currencyCode = json['currencyCode'];
//     _isDefault = json['isDefault'];
//   }
//   String? _name;
//   String? _symbol;
//   String? _countryCode;
//   String? _currencyCode;
//   bool? _isDefault;
//   Currency copyWith({
//     String? name,
//     String? symbol,
//     String? countryCode,
//     String? currencyCode,
//     bool? isDefault,
//   }) =>
//       Currency(
//         name: name ?? _name,
//         symbol: symbol ?? _symbol,
//         countryCode: countryCode ?? _countryCode,
//         currencyCode: currencyCode ?? _currencyCode,
//         isDefault: isDefault ?? _isDefault,
//       );
//   String? get name => _name;
//   String? get symbol => _symbol;
//   String? get countryCode => _countryCode;
//   String? get currencyCode => _currencyCode;
//   bool? get isDefault => _isDefault;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = _name;
//     map['symbol'] = _symbol;
//     map['countryCode'] = _countryCode;
//     map['currencyCode'] = _currencyCode;
//     map['isDefault'] = _isDefault;
//     return map;
//   }
// }
