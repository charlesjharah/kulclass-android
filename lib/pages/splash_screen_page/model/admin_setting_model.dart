class AdminSettingModel {
  bool? status;
  String? message;
  Data? data;

  AdminSettingModel({this.status, this.message, this.data});

  AdminSettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Currency? currency;
  Android? android;
  Android? ios;
  bool? isWatermarkOn;
  String? watermarkIcon;
  String? sId;
  bool? stripeSwitch;
  String? stripePublishableKey;
  String? stripeSecretKey;
  bool? razorPaySwitch;
  String? razorPayId;
  String? razorSecretKey;
  String? privacyPolicyLink;
  String? termsOfUsePolicyLink;
  String? zegoAppId;
  String? zegoAppSignIn;
  List<String>? paymentGateway;
  bool? isFakeData;
  int? durationOfShorts;
  int? minCoinForCashOut;
  int? minWithdrawalRequestedCoin;
  String? createdAt;
  String? updatedAt;
  int? watermarkType;
  PrivateKey? privateKey;
  List<String>? videoBanned;
  bool? googlePlaySwitch;
  String? androidLicenseKey;
  String? iosLicenseKey;
  String? sightengineSecret;
  String? sightengineUser;
  int? loginBonus;
  int? adDisplayIndex;
  String? flutterWaveId;
  bool? flutterWaveSwitch;
  bool? isChatAdEnabled;
  bool? isChatBackButtonAdEnabled;
  bool? isFeedAdEnabled;
  bool? isGoogle;
  bool? isLiveStreamBackButtonAdEnabled;
  bool? isVideoAdEnabled;
  bool? isEffectActive;

  Data(
      {this.currency,
      this.android,
      this.ios,
      this.isWatermarkOn,
      this.watermarkIcon,
      this.sId,
      this.stripeSwitch,
      this.stripePublishableKey,
      this.stripeSecretKey,
      this.razorPaySwitch,
      this.razorPayId,
      this.razorSecretKey,
      this.privacyPolicyLink,
      this.termsOfUsePolicyLink,
      this.zegoAppId,
      this.zegoAppSignIn,
      this.paymentGateway,
      this.isFakeData,
      this.durationOfShorts,
      this.minCoinForCashOut,
      this.minWithdrawalRequestedCoin,
      this.createdAt,
      this.updatedAt,
      this.watermarkType,
      this.privateKey,
      this.videoBanned,
      this.googlePlaySwitch,
      this.androidLicenseKey,
      this.iosLicenseKey,
      this.sightengineSecret,
      this.sightengineUser,
      this.loginBonus,
      this.adDisplayIndex,
      this.flutterWaveId,
      this.flutterWaveSwitch,
      this.isChatAdEnabled,
      this.isChatBackButtonAdEnabled,
      this.isFeedAdEnabled,
      this.isGoogle,
      this.isLiveStreamBackButtonAdEnabled,
      this.isVideoAdEnabled,
      this.isEffectActive});

  Data.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null ? new Currency.fromJson(json['currency']) : null;
    android = json['android'] != null ? new Android.fromJson(json['android']) : null;
    ios = json['ios'] != null ? new Android.fromJson(json['ios']) : null;
    isWatermarkOn = json['isWatermarkOn'];
    watermarkIcon = json['watermarkIcon'];
    sId = json['_id'];
    stripeSwitch = json['stripeSwitch'];
    stripePublishableKey = json['stripePublishableKey'];
    stripeSecretKey = json['stripeSecretKey'];
    razorPaySwitch = json['razorPaySwitch'];
    razorPayId = json['razorPayId'];
    razorSecretKey = json['razorSecretKey'];
    privacyPolicyLink = json['privacyPolicyLink'];
    termsOfUsePolicyLink = json['termsOfUsePolicyLink'];
    zegoAppId = json['zegoAppId'];
    zegoAppSignIn = json['zegoAppSignIn'];
    paymentGateway = json['paymentGateway'].cast<String>();
    isFakeData = json['isFakeData'];
    durationOfShorts = json['durationOfShorts'];
    minCoinForCashOut = json['minCoinForCashOut'];
    minWithdrawalRequestedCoin = json['minWithdrawalRequestedCoin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    watermarkType = json['watermarkType'];
    privateKey = json['privateKey'] != null ? new PrivateKey.fromJson(json['privateKey']) : null;
    videoBanned = json['videoBanned'].cast<String>();
    googlePlaySwitch = json['googlePlaySwitch'];
    androidLicenseKey = json['androidLicenseKey'];
    iosLicenseKey = json['iosLicenseKey'];
    sightengineSecret = json['sightengineSecret'];
    sightengineUser = json['sightengineUser'];
    loginBonus = json['loginBonus'];
    adDisplayIndex = json['adDisplayIndex'];
    flutterWaveId = json['flutterWaveId'];
    flutterWaveSwitch = json['flutterWaveSwitch'];
    isChatAdEnabled = json['isChatAdEnabled'];
    isChatBackButtonAdEnabled = json['isChatBackButtonAdEnabled'];
    isFeedAdEnabled = json['isFeedAdEnabled'];
    isGoogle = json['isGoogle'];
    isLiveStreamBackButtonAdEnabled = json['isLiveStreamBackButtonAdEnabled'];
    isVideoAdEnabled = json['isVideoAdEnabled'];
    isEffectActive = json['isEffectActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.android != null) {
      data['android'] = this.android!.toJson();
    }
    if (this.ios != null) {
      data['ios'] = this.ios!.toJson();
    }
    data['isWatermarkOn'] = this.isWatermarkOn;
    data['watermarkIcon'] = this.watermarkIcon;
    data['_id'] = this.sId;
    data['stripeSwitch'] = this.stripeSwitch;
    data['stripePublishableKey'] = this.stripePublishableKey;
    data['stripeSecretKey'] = this.stripeSecretKey;
    data['razorPaySwitch'] = this.razorPaySwitch;
    data['razorPayId'] = this.razorPayId;
    data['razorSecretKey'] = this.razorSecretKey;
    data['privacyPolicyLink'] = this.privacyPolicyLink;
    data['termsOfUsePolicyLink'] = this.termsOfUsePolicyLink;
    data['zegoAppId'] = this.zegoAppId;
    data['zegoAppSignIn'] = this.zegoAppSignIn;
    data['paymentGateway'] = this.paymentGateway;
    data['isFakeData'] = this.isFakeData;
    data['durationOfShorts'] = this.durationOfShorts;
    data['minCoinForCashOut'] = this.minCoinForCashOut;
    data['minWithdrawalRequestedCoin'] = this.minWithdrawalRequestedCoin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['watermarkType'] = this.watermarkType;
    if (this.privateKey != null) {
      data['privateKey'] = this.privateKey!.toJson();
    }
    data['videoBanned'] = this.videoBanned;
    data['googlePlaySwitch'] = this.googlePlaySwitch;
    data['androidLicenseKey'] = this.androidLicenseKey;
    data['iosLicenseKey'] = this.iosLicenseKey;
    data['sightengineSecret'] = this.sightengineSecret;
    data['sightengineUser'] = this.sightengineUser;
    data['loginBonus'] = this.loginBonus;
    data['adDisplayIndex'] = this.adDisplayIndex;
    data['flutterWaveId'] = this.flutterWaveId;
    data['flutterWaveSwitch'] = this.flutterWaveSwitch;
    data['isChatAdEnabled'] = this.isChatAdEnabled;
    data['isChatBackButtonAdEnabled'] = this.isChatBackButtonAdEnabled;
    data['isFeedAdEnabled'] = this.isFeedAdEnabled;
    data['isGoogle'] = this.isGoogle;
    data['isLiveStreamBackButtonAdEnabled'] = this.isLiveStreamBackButtonAdEnabled;
    data['isVideoAdEnabled'] = this.isVideoAdEnabled;
    data['isEffectActive'] = this.isEffectActive;
    return data;
  }
}

class Currency {
  String? name;
  String? symbol;
  String? countryCode;
  String? currencyCode;
  bool? isDefault;

  Currency({this.name, this.symbol, this.countryCode, this.currencyCode, this.isDefault});

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    countryCode = json['countryCode'];
    currencyCode = json['currencyCode'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['countryCode'] = this.countryCode;
    data['currencyCode'] = this.currencyCode;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

class Android {
  Google? google;

  Android({this.google});

  Android.fromJson(Map<String, dynamic> json) {
    google = json['google'] != null ? new Google.fromJson(json['google']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.google != null) {
      data['google'] = this.google!.toJson();
    }
    return data;
  }
}

class Google {
  String? interstitial;
  String? native;

  Google({this.interstitial, this.native});

  Google.fromJson(Map<String, dynamic> json) {
    interstitial = json['interstitial'];
    native = json['native'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interstitial'] = this.interstitial;
    data['native'] = this.native;
    return data;
  }
}

class PrivateKey {
  String? type;
  String? projectId;
  String? privateKeyId;
  String? privateKey;
  String? clientEmail;
  String? clientId;
  String? authUri;
  String? tokenUri;
  String? authProviderX509CertUrl;
  String? clientX509CertUrl;
  String? universeDomain;

  PrivateKey(
      {this.type,
      this.projectId,
      this.privateKeyId,
      this.privateKey,
      this.clientEmail,
      this.clientId,
      this.authUri,
      this.tokenUri,
      this.authProviderX509CertUrl,
      this.clientX509CertUrl,
      this.universeDomain});

  PrivateKey.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    projectId = json['project_id'];
    privateKeyId = json['private_key_id'];
    privateKey = json['private_key'];
    clientEmail = json['client_email'];
    clientId = json['client_id'];
    authUri = json['auth_uri'];
    tokenUri = json['token_uri'];
    authProviderX509CertUrl = json['auth_provider_x509_cert_url'];
    clientX509CertUrl = json['client_x509_cert_url'];
    universeDomain = json['universe_domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['project_id'] = this.projectId;
    data['private_key_id'] = this.privateKeyId;
    data['private_key'] = this.privateKey;
    data['client_email'] = this.clientEmail;
    data['client_id'] = this.clientId;
    data['auth_uri'] = this.authUri;
    data['token_uri'] = this.tokenUri;
    data['auth_provider_x509_cert_url'] = this.authProviderX509CertUrl;
    data['client_x509_cert_url'] = this.clientX509CertUrl;
    data['universe_domain'] = this.universeDomain;
    return data;
  }
}
