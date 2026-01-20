import 'dart:io';
import 'package:auralive/google_ad/google_ad_setting_api.dart';

// *** >>> Google Ad Code <<< ***

class GoogleAdServices {
  static bool isShowInterstitialAdLive = GoogleAdSettingApi.googleAdSettingModel?.adSetting?.isLiveStreamBackButtonAdEnabled ?? false;
  static bool isShowInterstitialAdChat = GoogleAdSettingApi.googleAdSettingModel?.adSetting?.isChatBackButtonAdEnabled ?? false;

  static bool isShowLargeNativeAdFeed = GoogleAdSettingApi.googleAdSettingModel?.adSetting?.isFeedAdEnabled ?? false;
  static bool isShowSmallNativeAdMessage = GoogleAdSettingApi.googleAdSettingModel?.adSetting?.isChatAdEnabled ?? false;
  static bool isShowFullNativeAdReels = GoogleAdSettingApi.googleAdSettingModel?.adSetting?.isVideoAdEnabled ?? false;

  static int adShowIndex = GoogleAdSettingApi.googleAdSettingModel?.adSetting?.adDisplayIndex ?? 5;

  static String get nativeAd => Platform.isAndroid
      ? (GoogleAdSettingApi.googleAdSettingModel?.adSetting?.android?.google?.native ?? "")
      : Platform.isIOS
          ? (GoogleAdSettingApi.googleAdSettingModel?.adSetting?.ios?.google?.native ?? "")
          : "Platform Not Support !!";

  static String get interstitialAd => Platform.isAndroid
      ? (GoogleAdSettingApi.googleAdSettingModel?.adSetting?.android?.google?.interstitial ?? "")
      : Platform.isIOS
          ? (GoogleAdSettingApi.googleAdSettingModel?.adSetting?.ios?.google?.interstitial ?? "")
          : "Platform Not Support !!";
}
