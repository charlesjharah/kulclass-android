import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:auralive/google_ad/google_ad_services.dart';

// *** >>> Google Ad Code <<< ***

class GoogleAdInterstitial {
  static bool _isLoaded = false; // This Variable Use to Check Ads Is Loaded or Not
  static Function function = () {}; // This Function Use to Navigation...

  static InterstitialAd? interstitialAd;

  static void loadAd() {
    debugPrint("Google Interstitial Ads Loading...");
    _isLoaded = false;
    InterstitialAd.load(
      adUnitId: GoogleAdServices.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoaded = true;
          ad.fullScreenContentCallback = FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
            debugPrint("Interstitial Ad Showed");
          }, onAdImpression: (ad) {
            debugPrint("Interstitial Ad Impression");
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint("Interstitial Ad Loading Failed =>$error");
            ad.dispose();
          }, onAdDismissedFullScreenContent: (ad) {
            function();
            debugPrint("Interstitial Ad Closed");
            ad.dispose();
          }, onAdClicked: (ad) {
            debugPrint("Interstitial Ad On Clicked");
          });
          debugPrint("Interstitial Ad Loaded Success");
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Interstitial Ad Loading Failed => $error');
        },
      ),
    );
  }

  static showAd({Function? navigation}) {
    function = () => navigation!();
    if (_isLoaded) {
      interstitialAd!.show();
      debugPrint("Interstitial Ad Show Success");
    } else {
      function();
      debugPrint("Interstitial Ad Not Show !!");
    }
    loadAd();
  }
}
