import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:auralive/google_ad/google_ad_services.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';

// *** >>> Google Ad Code <<< ***

class GoogleAdSmallNative extends StatefulWidget {
  const GoogleAdSmallNative({super.key});

  @override
  State<GoogleAdSmallNative> createState() => _GoogleAdSmallNativeState();
}

class _GoogleAdSmallNativeState extends State<GoogleAdSmallNative> {
  NativeAd? nativeAd;
  RxString isLoading = "loading".obs;

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  Future<void> loadAd() async {
    debugPrint("Google Small Native Ads Loading...");
    nativeAd = NativeAd(
      adUnitId: GoogleAdServices.nativeAd,
      factoryId: 'medium',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAd = ad as NativeAd;
          isLoading.value = "success";
          debugPrint("Google Small Native Ads Loaded Success");
        },
        onAdWillDismissScreen: (ad) {
          debugPrint("Google Small Native Ads Dismiss");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint("Google Small Native Ads Loading Failed => $error");
          isLoading.value = "failed";
          ad.dispose();
        },
      ),
    );
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoading.value == "loading")
          ? Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: AppColor.colorBorder.withOpacity(0.4)),
              alignment: Alignment.center,
              child: Text(
                "Advertisement Loading...",
                style: AppFontStyle.styleW700(AppColor.black, 14),
              ),
            )
          : (isLoading.value == "success")
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  height: 70,
                  child: AdWidget(ad: nativeAd!),
                )
              : Offstage(),
    );
  }
}
