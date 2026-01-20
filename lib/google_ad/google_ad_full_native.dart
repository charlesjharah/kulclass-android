import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:auralive/google_ad/google_ad_services.dart';
import 'package:auralive/utils/color.dart';
import 'package:auralive/utils/font_style.dart';

// *** >>> Google Ad Code <<< ***

class GoogleAdFullNative extends StatefulWidget {
  const GoogleAdFullNative({super.key});

  @override
  State<GoogleAdFullNative> createState() => _GoogleAdFullNativeState();
}

class _GoogleAdFullNativeState extends State<GoogleAdFullNative> {
  NativeAd? nativeAd;
  RxString isLoading = "loading".obs;

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  Future<void> loadAd() {
    debugPrint("Google Large Native Ads Loading...");
    nativeAd = NativeAd(
      adUnitId: GoogleAdServices.nativeAd,
      factoryId: 'full',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAd = ad as NativeAd;
          isLoading.value = "success";
          debugPrint("Google Full Native Ads Loaded Success");
        },
        onAdWillDismissScreen: (ad) {
          debugPrint("Google Full Native Ads Dismiss");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint("Google Full Native Ads Loading Failed => $error");
          isLoading.value = "failed";
          ad.dispose();
        },
      ),
    );
    return nativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoading.value == "loading")
          ? Container(
              height: Get.height,
              width: Get.width,
              color: AppColor.colorBorder.withOpacity(0.4),
              alignment: Alignment.center,
              child: Text(
                "Advertisement Loading...",
                style: AppFontStyle.styleW700(AppColor.black, 15),
              ),
            )
          : (isLoading.value == "success")
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: AdWidget(ad: nativeAd!),
                )
              : Container(
                  height: Get.height,
                  width: Get.width,
                  color: AppColor.colorBorder.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: Text(
                    "Advertisement Loading...",
                    style: AppFontStyle.styleW700(AppColor.black, 15),
                  ),
                ),
    );
  }
}
